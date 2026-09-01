function fig = plot_result(strata_trapped, param_id, args)
arguments
    strata_trapped (1,1) struct
    param_id (1,1) uint8
    args.font_size = 14
    args.kr_scale = "log"
    args.parent = struct([]);
    args.visible char = 'on';
    args.font_name char = 'Arial';
    args.line_thickness = 2;
end

if isempty(args.parent)
    fig = figure('Visible',args.visible);
else
    fig = args.parent;
    clf(fig);
end

[t_all,t_kr,t_krw,t_krg,ax_pc,ax_krw_x,ax_krw_y,ax_krw_z,ax_krg_x,ax_krg_y,ax_krg_z] ...
    = nested_tiles(fig);

saturation = strata_trapped.saturation(param_id,:);

leverett_j = dequantize(strata_trapped.tables(param_id,1)).leverett_j;

font_args = {'FontName',args.font_name,'FontSize',args.font_size,'FontWeight','normal'};

param_id_for_display = param_id;
if isscalar(strata_trapped.params)
    param_id_for_display = [];
end

[~, ax_pc] =  stat_plot(ax_pc,saturation,...
    @(sw)strata_trapped.params(param_id).cap_pressure.leverett_j.func(sw),...
    leverett_j,font_args,args.line_thickness,true,param_id_for_display);

title(ax_pc,'Leverett J-function',font_args{:});
% ylabel(ax_pc,'[-]');
ax_pc.YScale='log';

curves_plot([ax_krw_x,ax_krw_y,ax_krw_z;ax_krg_x,ax_krg_y,ax_krg_z], saturation, ...
    strata_trapped.tables(param_id,:), strata_trapped.params(param_id), font_args, args.line_thickness,args.kr_scale);

xlabel(t_all,'Wetting phase saturation',font_args{:});
title(t_kr,'Relative permeability',font_args{:});
subtitle(t_krw,'Water',font_args{:});
subtitle(t_krg,'Gas',font_args{:});

subtitle(ax_krw_x,'x',font_args{:});
subtitle(ax_krw_y,'y',font_args{:});
subtitle(ax_krw_z,'z',font_args{:});
subtitle(ax_krg_x,'x',font_args{:});
subtitle(ax_krg_y,'y',font_args{:});
subtitle(ax_krg_z,'z',font_args{:});
end


function curves_plot(ax_kr, saturation, dequantized, params, font_args,line_thickness,scale)
arguments
    ax_kr
    saturation
    dequantized
    params
    font_args
    line_thickness
    scale = "log"
end

stat_plot(ax_kr(1,1),saturation,@(sw)params.krw.func(sw),dequantized(1).krw,font_args,line_thickness);
ax_kr(1,1).YScale = scale;

stat_plot(ax_kr(2,1),saturation,@(sw) params.krg.func(1-sw),dequantized(1).krg,font_args,line_thickness);
ax_kr(2,1).YScale = scale;

stat_plot(ax_kr(1,2),saturation,@(sw)params.krw.func(sw),dequantized(2).krw,font_args,line_thickness);
ax_kr(1,2).YScale = scale;

stat_plot(ax_kr(2,2),saturation,@(sw) params.krg.func(1-sw),dequantized(2).krg,font_args,line_thickness);
ax_kr(2,2).YScale = scale;

stat_plot(ax_kr(1,3),saturation,@(sw)params.krw.func(sw),dequantized(3).krw,font_args,line_thickness);
ax_kr(1,3).YScale = scale;

stat_plot(ax_kr(2,3),saturation,@(sw) params.krg.func(1-sw),dequantized(3).krg,font_args,line_thickness);
ax_kr(2,3).YScale = scale;
end


function [y_lim, ax] = stat_plot(ax, x_data, base_func, data,font_args,...
    line_thickness,show_legend,param_id, color)
arguments
    ax
    x_data (1,:) double
    base_func
    data   (:,:) double
    font_args
    line_thickness
    show_legend (1,1) logical = false;
    param_id = [];
    color = 'blue'
end

parallelcoords(ax,data,'Quantile',0.01,'XData',x_data,'Color',color,'LineWidth',line_thickness);

if ~isempty(base_func)
    hold(ax,'on');
    plot(ax,x_data,base_func(x_data),'-r','LineWidth',line_thickness);
    hold(ax,'off');
end

ylabel(ax,'');
xlabel(ax,'');
ax.XTickMode='auto';
ax.XTickLabelMode='auto';
ax.XLimitMethod="tickaligned";

ax.YLimitMethod="tight";

set(ax,font_args{:});

if show_legend
    legends = {'Median','Quantiles 0.01 and 0.99',''};
    if ~isempty(base_func)
        param_id_str = '';
        if ~isempty(param_id)
            param_id_str = sprintf(' (id: %u)',param_id);
        end
        legends{end+1} = sprintf('Fine-scale curve%s',param_id_str);
    end

    legend(ax,legends,'Location','northoutside',font_args{:});
end

try
    [yu,yl,ym] = ax.Children(:).YData;
    ydata = [yu,yl,ym];
    y_lim = [min(ydata),max(ydata)];
catch
    y_lim = [nan,nan];
end
end

function [t_all,t_kr,t_krw,t_krg,ax_pc,ax_krw_x,ax_krw_y,ax_krw_z,ax_krg_x,ax_krg_y,ax_krg_z] ...
    = nested_tiles(fig)
params = {'TileSpacing','tight','Padding','tight'};
t_all = tiledlayout(fig,1,3,params{:});


t_pc = tiledlayout(t_all,1,1,params{:});
t_pc.Layout.Tile = 1;
ax_pc = nexttile(t_pc);

t_kr = tiledlayout(t_all,1,2,params{:});
t_kr.Layout.Tile = 2;
t_kr.Layout.TileSpan = [1,2];


t_krw = tiledlayout(t_kr,3,1,params{:});
t_krw.Layout.Tile = 1;

ax_krw_x = nexttile(t_krw,1);
ax_krw_y = nexttile(t_krw,2);
ax_krw_z = nexttile(t_krw,3);


t_krg = tiledlayout(t_kr,3,1,params{:});
t_krg.Layout.Tile = 2;

ax_krg_x = nexttile(t_krg,1);
ax_krg_y = nexttile(t_krg,2);
ax_krg_z = nexttile(t_krg,3);
end

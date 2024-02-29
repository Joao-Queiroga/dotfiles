{ ... }: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      vim_keys = true;
      cpu_single_graph = true;
      update_ms = 1000;
      proc_sorting = "pid";
      proc_tree = true;
      proc_gradient = false;
      proc_filter_kernel = true;
      mem_graphs = false;
    };
  };
}

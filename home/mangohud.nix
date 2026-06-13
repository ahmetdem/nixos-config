{ ... }:

{
  programs.mangohud = {
    enable = true;
    settings = {
      fps = true;
      frametime = true;
      frame_timing = true;

      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_power = true;
      throttling_status = true;

      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;

      ram = true;
      vram = true;

      fps_metrics = "avg,0.01";
      fps_limit = "0,60,144";
      toggle_fps_limit = "Shift_L+F1";

      position = "top-left";
      hud_compact = true;
      font_size = 20;
      background_alpha = 0.4;

      no_display = false;
      toggle_hud = "Shift_R+F12";
    };
  };
}

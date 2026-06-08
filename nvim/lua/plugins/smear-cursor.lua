return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#5fffe0",
    stiffness = 0.8, -- 0.6 is default. Higher is faster
    trailing_stiffness = 0.8, -- 0.45 is default
    damping = 0.95, -- 0.85 is default. Higher reduces bounciness
    time_interval = 5, -- 17ms is default. Lowering this increases framerate
  },
}

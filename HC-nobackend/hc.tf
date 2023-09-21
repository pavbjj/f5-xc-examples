resource "volterra_healthcheck" "volterra_health_check" {
  name      = "p-kuligowski-crawford-hc-1"
  namespace = "sandbox"

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 3
  interval            = 15
  timeout             = 3
  unhealthy_threshold = 1
  jitter_percent      = 30
}

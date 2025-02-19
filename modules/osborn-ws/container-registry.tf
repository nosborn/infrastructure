resource "scaleway_container_namespace" "this" {
  name = "osborn-ws"
}

resource "scaleway_registry_namespace" "this" {
  is_public = false
  name      = scaleway_container_namespace.this.name
}

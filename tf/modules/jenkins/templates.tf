data "template_file" "init" {
  template = "${file("${path.module}/templates/userdata.tpl")}"
}

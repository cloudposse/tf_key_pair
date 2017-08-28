data "template_file" "default" {
  template = "${file("${var.ssh_public_key_path}")}"
}


module "label" {
  source    = "git::https://github.com/cloudposse/tf_label.git?ref=tags/0.2.0"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
  name      = "${var.name}"
}

resource "aws_key_pair" "default" {
  key_name   = "${module.label.id}"
  public_key = "${data.template_file.default.rendered}"
}

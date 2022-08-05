data "aws_region" "current" {}

locals {
  aws_region_shortname     = replace(data.aws_region.current.name, "/(\\w\\w).*-(\\w).*-(\\d).*$/", "$1$2$3")
  string_used_for_fake_ids = sha256(join("", [var.namespace, var.environment, local.aws_region_shortname, var.cidr_block, var.subnet_count]))

  vpc_name = join("-", [var.namespace, var.environment, local.aws_region_shortname, "vpc"])
  vpc_id   = join("-", ["vpc", substr(local.string_used_for_fake_ids, 0, 7)])

  subnet_ids = [for i in range(var.subnet_count) :
    join("-", ["subnet", substr(local.string_used_for_fake_ids, i + 7, 7)])
  ]

  subnet_names = { for k in range(var.subnet_count) :
    local.subnet_ids[k] => join("-",
      [
        var.namespace,
        var.environment,
        local.aws_region_shortname,
        (contains(split("", tostring(k / 2)), ".") ? "public" : "private"),
        "subnet",
        k + 1
      ]
    )
  }

  subnet_cidr_blocks = { for m in range(var.subnet_count) :
    local.subnet_names[local.subnet_ids[m]] => cidrsubnet(var.cidr_block, 4, m)
  }

  subnet_id_cidr_blocks = { for m in range(var.subnet_count) :
    local.subnet_ids[m] => cidrsubnet(var.cidr_block, 4, m)
  }
}

resource "null_resource" "vpc" {
  triggers = {
    destroy_vpc_if_region_changed = data.aws_region.current.name
    destroy_vpc_if_name_changed   = local.vpc_name
    destroy_vpc_if_cidr_changed   = var.cidr_block
  }
}

resource "null_resource" "private_subnets" {
  triggers = {
    destroy_vpc_if_region_changed = data.aws_region.current.name
    destroy_vpc_if_name_changed   = local.vpc_name
    destroy_vpc_if_cidr_changed   = var.cidr_block

    destroy_subnets_if_subnet_count_changed = var.subnet_count
    destroy_subnets_if_subnet_ids_changed   = local.subnet_ids[0]
  }
}

resource "null_resource" "public_subnets" {
  triggers = {
    destroy_vpc_if_region_changed = data.aws_region.current.name
    destroy_vpc_if_name_changed   = local.vpc_name
    destroy_vpc_if_cidr_changed   = var.cidr_block

    destroy_subnets_if_subnet_count_changed = var.subnet_count
    destroy_subnets_if_subnet_ids_changed   = local.subnet_ids[0]
  }
}

resource "null_resource" "internet_gateway" {
  triggers = {
    destroy_vpc_if_region_changed = data.aws_region.current.name
    destroy_vpc_if_name_changed   = local.vpc_name
    destroy_vpc_if_cidr_changed   = var.cidr_block
  }
}

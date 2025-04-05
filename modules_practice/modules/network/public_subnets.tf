resource "aws_subnet" "public" {
    count = length(var.public_subnets_cidr_blocks)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.public_subnets_cidr_blocks, count.index)
    availability_zone = element(var.azs, count.index)

    tags = {
        Name = "${var.vpc_name}-public=${count.index + 1}"
        Owner = local.owner
        Costcenter = local.cost_center
        TeamDl = local.team_dl
    }
}
output "id" {
 value = aws_vpc.prodvpc.id

}

output "id-pr" {
 value = aws_subnet.private-sb.id
}


output "id-pub" { 
 value = aws_subnet.public-sb.id

}


output "id-dsg-sb" {
 value = aws_subnet.dsg-sb.id

}


output "id-ent-sb" {
 value = aws_subnet.ent-sb.id

}



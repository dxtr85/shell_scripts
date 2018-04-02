#!/usr/bin/awk -f
BEGIN {
# change the record separator from newline to nothing
	RS=""
# change the field separator from whitespace to newline
	FS="\n"
# change the output field separator from whitespace to newline
	OFS="\n"
}
{
# print the second and third line of the file
	print $2, $3;
}

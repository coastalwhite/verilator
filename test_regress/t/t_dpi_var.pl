#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);
my $out_filename = "$Self->{obj_dir}/V$Self->{name}.xml";

compile(
    make_top_shell => 0,
    make_main => 0,
    verilator_flags2 => ["-DATTRIBUTES --exe --no-l2name $Self->{t_dir}/t_dpi_var.cpp"],
    );

if ($Self->{vlt_all}) {
    file_grep("$out_filename", qr/\<var fl="d55" loc=".*?" name="formatted" dtype_id="4" dir="input" vartype="string" origName="formatted" sformat="true"\/\>/i);
    file_grep("$out_filename", qr/\<var fl="d76" loc=".*?" name="t.sub.in" dtype_id="3" vartype="int" origName="in" public="true" public_flat_rd="true"\/\>/i);
    file_grep("$out_filename", qr/\<var fl="d77" loc=".*?" name="t.sub.fr_a" dtype_id="3" vartype="int" origName="fr_a" public="true" public_flat_rd="true" public_flat_rw="true"\/\>/i);
    file_grep("$out_filename", qr/\<var fl="d78" loc=".*?" name="t.sub.fr_b" dtype_id="3" vartype="int" origName="fr_b" public="true" public_flat_rd="true" public_flat_rw="true"\/\>/i);
}

execute(
    check_finished => 1,
    );

ok(1);
1;

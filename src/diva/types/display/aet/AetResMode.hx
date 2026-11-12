package diva.types.display.aet;

import cpp.Int32;

// Since 1.0.0-alpha.3
enum abstract AetResMode(Int32) from Int32 to Int32 {
	var Res_QVGA = 0x00;
	var Res_VGA = 0x01;
	var Res_SVGA = 0x02;
	var Res_XGA = 0x03;
	var Res_SXGA = 0x04;
	var Res_SXGAPlus = 0x05;
	var Res_UXGA = 0x06;
	var Res_WVGA = 0x07;
	var Res_WSVGA = 0x08;
	var Res_WXGA = 0x09;
	var Res_FWXGA = 0x0A;
	var Res_WUXGA = 0x0B;
	var Res_WQXGA = 0x0C;
	var Res_HD = 0x0D;
	var Res_FHD = 0x0E;
	var Res_UHD = 0x0F;
	var Res_3KatUHD = 0x10;
	var Res_3K = 0x11;
	var Res_QHD = 0x12;
	var Res_WQVGA = 0x13;
	var Res_qHD = 0x14;
	var Res_XGA_P = 0x15;
	var Res_1176x664 = 0x16;
	var Res_1200x960 = 0x17;
	var Res_WXGA1280x900 = 0x18;
	var Res_SXGA_M = 0x19;
	var Res_FWXGA1366x768 = 0x1A;
	var Res_WXGA_P = 0x1B;
	var Res_HDPlus = 0x1C;
	var Res_WSXGA = 0x1D;
	var Res_WSXGAPlus = 0x1E;
	var Res_1920x1440 = 0x1F;
	var Res_QWXGA = 0x20;
	var Res_MAX = 0x21;
}

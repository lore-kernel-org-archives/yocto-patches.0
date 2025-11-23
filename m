Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D96CCFD316
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 22:02:52 +0000 (UTC)
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3154.1763935364032998713
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 14:02:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=G8RsqX2p;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.146.64, mailfrom: prvs=04223c8124=hemant.jadhav@emerson.com)
Received: from pps.filterd (m0484888.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ANHpoMh011138
	for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 22:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=PePMRNCQITgnysbyzIu+NOlouN
	KewT0BdtvrRgN8UgM=; b=G8RsqX2pnSNRyKPLyADmP9eO4MF+020V7mNewDAArH
	SscNh6NK3aB9MXdvrwWo6aGxczxqXDWfzybASBErpmrLa85eNWknaeQg6Aal5Gdw
	zkoAsCcEu96CxGwP0T/V9PQL9Tm1czY1GRZsDEQzXVbL1+LkN5Q/IwjLQMQ6FJcY
	IMuJujoBVr+mAXYuFEPc2DAgeKY2jbem/8xLXaC817rFSP3R8qghZLrOSSzvr9iS
	ClR+5W5oEilmF2hu67bQmt1ltfFM8Y2JWeGev6YfenKuVZ1Vh0WraulJws2zI/dG
	1Mvg2MB2boZop3zA5uVWcADQCOD03Z3jGgBH5IiUbuUw==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4aktr5apse-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 22:02:40 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 23 Nov 2025 16:02:28 -0600
Received: from hjadhav-Virtual-Machine.mshome.net (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 23 Nov 2025 16:02:28
 -0600
From: Hemant Jadhav <hemant.jadhav@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Hemant Jadhav <hemant.jadhav@emerson.com>
Subject: [yocto-patches][meta-security][PATCH V7] clamav: Add recipe for version 1.4.3
Date: Sun, 23 Nov 2025 16:02:25 -0600
Message-ID: <20251123220226.370770-1-hemant.jadhav@emerson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -f6Xz9RI22YMZmlBOrcvTO2-vaQ6l-BD
X-Proofpoint-ORIG-GUID: -f6Xz9RI22YMZmlBOrcvTO2-vaQ6l-BD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIzMDAzMSBTYWx0ZWRfXzkEBqv+sstl/ mZdYPbNr0e625z3oiD+1GTe+ODbt1zZqBNIRexponxId+YtrIHnAtItLRAEf1g+/VVKPP96Y7RZ 0WFgTTOjsgs2XaCJPOnr5h8q3JNoXzvY/+QDIzrFh2isYgqYmDdKGtHg5c/jDY/NbN+Mhub8ZSa
 ARp3uecvz4ewMLTfXzTlPKSlJBdxSRFiyVWJd5OtG4cP8FCaDv/8+XUvPsQjE4XnXTqmOjODJEe Zk38ZLZpDWxseS3NrPTpDRcYeftCeh2HbIFeV7jcAwrU76TS6w8hwxmpa/vuExUoJcOeEFJ7rTd n4XDK7b13kyb50jNu7fYXAoi/Bs6jC7qZr3id+fMKb7MgwfPr/bCQ6ocj+ow+WuptmYxNis6Y9I
 uKh9oHdxHmE6AaBFUxtWIykM01k+cw==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69238480 cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=tPundid6AAAA:8 a=geDs06hvAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=Nc5OGPALQcFPbVPI-_AA:9 a=aPicV9olnlo_TREvANR5:22 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_08,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510240000 definitions=main-2511230031
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 22:02:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2656

Add modern ClamAV 1.4.3 recipe with comprehensive improvements over
the legacy 0.104.4 version. Remove the end-of-life 0.104.4 recipe and
associated patches as they are superseded by this version.

Major changes in 1.4.3:
- Upgraded core engine with improved threat detection capabilities
- Added Rust components requiring cross-compilation support
- Updated CMake build system replacing legacy autotools
- Modernized library dependencies (LLVM, JSON-C, PCre2)
- Added comprehensive license compliance for multi-component package
- Enhanced cross-compilation support for all target architectures

The recipe includes dynamic Cargo configuration using Yocto variables
to support cross-compilation to any target architecture supported by
the build system.

Runtime configuration improvements:
- Set APP_CONFIG_DIRECTORY to ${sysconfdir}/clamav for proper config paths
- Added volatiles/tmpfiles support for /var/lib/clamav and /var/log/clamav
- Added pkg_postinst scripts to ensure correct directory ownership
- Implemented CMake cache variables for cross-compilation
- Updated all license checksums for compliance
- Added Rust toolchain integration with automatic environment setup
- Use Cargo vendoring with cargo + cargo-update-recipe-crates classes

Security rationale:
- ClamAV 0.104.4 reached end-of-life and is no longer maintained
- Upstream strongly recommends migration to 1.4.x for security updates

Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>

diff --git a/recipes-scanners/clamav/clamav-crates.inc b/recipes-scanners/clamav/clamav-crates.inc
new file mode 100644
index 0000000..ed7f453
--- /dev/null
+++ b/recipes-scanners/clamav/clamav-crates.inc
@@ -0,0 +1,286 @@
+# Autogenerated with 'bitbake -c update_crates clamav'
+
+# from Cargo.lock
+SRC_URI += " \
+    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/adler32/1.2.0 \
+    crate://crates.io/aho-corasick/1.1.3 \
+    crate://crates.io/android-tzdata/0.1.1 \
+    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/autocfg/1.3.0 \
+    crate://crates.io/base64/0.21.7 \
+    crate://crates.io/bindgen/0.65.1 \
+    crate://crates.io/bit_field/0.10.2 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bitflags/2.5.0 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/bumpalo/3.16.0 \
+    crate://crates.io/bytemuck/1.21.0 \
+    crate://crates.io/byteorder/1.5.0 \
+    crate://crates.io/bytes/1.9.0 \
+    crate://crates.io/bzip2-rs/0.1.2 \
+    crate://crates.io/cbindgen/0.25.0 \
+    crate://crates.io/cc/1.0.97 \
+    crate://crates.io/cexpr/0.6.0 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/chrono/0.4.38 \
+    crate://crates.io/clang-sys/1.7.0 \
+    crate://crates.io/color_quant/1.1.0 \
+    crate://crates.io/core-foundation-sys/0.8.6 \
+    crate://crates.io/cpufeatures/0.2.12 \
+    crate://crates.io/crc32fast/1.4.0 \
+    crate://crates.io/crossbeam-deque/0.8.5 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-utils/0.8.19 \
+    crate://crates.io/crunchy/0.2.2 \
+    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/delharc/0.6.1 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/either/1.11.0 \
+    crate://crates.io/encoding_rs/0.8.34 \
+    crate://crates.io/enum-primitive-derive/0.2.2 \
+    crate://crates.io/errno/0.3.8 \
+    crate://crates.io/exr/1.72.0 \
+    crate://crates.io/fastrand/2.1.0 \
+    crate://crates.io/fdeflate/0.3.4 \
+    crate://crates.io/flate2/1.0.30 \
+    crate://crates.io/flume/0.11.0 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/gif/0.13.1 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/half/2.4.1 \
+    crate://crates.io/hashbrown/0.12.3 \
+    crate://crates.io/heck/0.4.1 \
+    crate://crates.io/hex/0.4.3 \
+    crate://crates.io/hex-literal/0.4.1 \
+    crate://crates.io/home/0.5.9 \
+    crate://crates.io/iana-time-zone/0.1.60 \
+    crate://crates.io/iana-time-zone-haiku/0.1.2 \
+    crate://crates.io/image/0.24.9 \
+    crate://crates.io/indexmap/1.9.3 \
+    crate://crates.io/inflate/0.4.5 \
+    crate://crates.io/itertools/0.10.5 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/jpeg-decoder/0.3.1 \
+    crate://crates.io/js-sys/0.3.69 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/lazycell/1.3.0 \
+    crate://crates.io/lebe/0.5.2 \
+    crate://crates.io/libc/0.2.155 \
+    crate://crates.io/libloading/0.8.3 \
+    crate://crates.io/linux-raw-sys/0.4.13 \
+    crate://crates.io/lock_api/0.4.12 \
+    crate://crates.io/log/0.4.21 \
+    crate://crates.io/memchr/2.7.2 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/miniz_oxide/0.7.2 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/num-complex/0.4.5 \
+    crate://crates.io/num-integer/0.1.46 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/once_cell/1.19.0 \
+    crate://crates.io/paste/1.0.14 \
+    crate://crates.io/peeking_take_while/0.1.2 \
+    crate://crates.io/png/0.17.13 \
+    crate://crates.io/prettyplease/0.2.19 \
+    crate://crates.io/primal-check/0.3.3 \
+    crate://crates.io/proc-macro2/1.0.81 \
+    crate://crates.io/qoi/0.4.1 \
+    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/rayon/1.10.0 \
+    crate://crates.io/rayon-core/1.12.1 \
+    crate://crates.io/regex/1.10.4 \
+    crate://crates.io/regex-automata/0.4.6 \
+    crate://crates.io/regex-syntax/0.8.3 \
+    crate://crates.io/rustc-hash/1.1.0 \
+    crate://crates.io/rustdct/0.7.1 \
+    crate://crates.io/rustfft/6.2.0 \
+    crate://crates.io/rustix/0.38.34 \
+    crate://crates.io/ryu/1.0.17 \
+    crate://crates.io/scopeguard/1.2.0 \
+    crate://crates.io/serde/1.0.200 \
+    crate://crates.io/serde_derive/1.0.200 \
+    crate://crates.io/serde_json/1.0.116 \
+    crate://crates.io/sha1/0.10.6 \
+    crate://crates.io/sha2/0.10.8 \
+    crate://crates.io/shlex/1.3.0 \
+    crate://crates.io/simd-adler32/0.3.7 \
+    crate://crates.io/smallvec/1.13.2 \
+    crate://crates.io/spin/0.9.8 \
+    crate://crates.io/strength_reduce/0.2.4 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.60 \
+    crate://crates.io/tempfile/3.10.1 \
+    crate://crates.io/thiserror/1.0.59 \
+    crate://crates.io/thiserror-impl/1.0.59 \
+    crate://crates.io/tiff/0.9.1 \
+    crate://crates.io/tinyvec/1.6.0 \
+    crate://crates.io/toml/0.5.11 \
+    crate://crates.io/transpose/0.2.3 \
+    crate://crates.io/typenum/1.17.0 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/unicode-segmentation/1.11.0 \
+    crate://crates.io/uuid/1.8.0 \
+    crate://crates.io/version_check/0.9.4 \
+    crate://crates.io/wasm-bindgen/0.2.92 \
+    crate://crates.io/wasm-bindgen-backend/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
+    crate://crates.io/wasm-bindgen-shared/0.2.92 \
+    crate://crates.io/weezl/0.1.8 \
+    crate://crates.io/which/4.4.2 \
+    crate://crates.io/widestring/1.1.0 \
+    crate://crates.io/windows-core/0.52.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.52.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.5 \
+    crate://crates.io/windows_i686_gnu/0.52.5 \
+    crate://crates.io/windows_i686_gnullvm/0.52.5 \
+    crate://crates.io/windows_i686_msvc/0.52.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.5 \
+    crate://crates.io/zune-inflate/0.2.54 \
+"
+
+SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[adler32-1.2.0.sha256sum] = "aae1277d39aeec15cb388266ecc24b11c80469deae6067e17a1a7aa9e5c1f234"
+SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
+SRC_URI[android-tzdata-0.1.1.sha256sum] = "e999941b234f3131b00bc13c22d06e8c5ff726d1b6318ac7eb276997bbb4fef0"
+SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[autocfg-1.3.0.sha256sum] = "0c4b4d0bd25bd0b74681c0ad21497610ce1b7c91b1022cd21c80c6fbdd9476b0"
+SRC_URI[base64-0.21.7.sha256sum] = "9d297deb1925b89f2ccc13d7635fa0714f12c87adce1c75356b39ca9b7178567"
+SRC_URI[bindgen-0.65.1.sha256sum] = "cfdf7b466f9a4903edc73f95d6d2bcd5baf8ae620638762244d3f60143643cc5"
+SRC_URI[bit_field-0.10.2.sha256sum] = "dc827186963e592360843fb5ba4b973e145841266c1357f7180c43526f2e5b61"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bitflags-2.5.0.sha256sum] = "cf4b9d6a944f767f8e5e0db018570623c85f3d925ac718db4e06d0187adb21c1"
+SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[bumpalo-3.16.0.sha256sum] = "79296716171880943b8470b5f8d03aa55eb2e645a4874bdbb28adb49162e012c"
+SRC_URI[bytemuck-1.21.0.sha256sum] = "ef657dfab802224e671f5818e9a4935f9b1957ed18e58292690cc39e7a4092a3"
+SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
+SRC_URI[bytes-1.9.0.sha256sum] = "325918d6fe32f23b19878fe4b34794ae41fc19ddbe53b10571a4874d44ffd39b"
+SRC_URI[bzip2-rs-0.1.2.sha256sum] = "beeb59e7e4c811ab37cc73680c798c7a5da77fc9989c62b09138e31ee740f735"
+SRC_URI[cbindgen-0.25.0.sha256sum] = "faeaa693e5a727975a79211b8f35c0cb09b031fdb6eaa4a788bc6713d01488ca"
+SRC_URI[cc-1.0.97.sha256sum] = "099a5357d84c4c61eb35fc8eafa9a79a902c2f76911e5747ced4e032edd8d9b4"
+SRC_URI[cexpr-0.6.0.sha256sum] = "6fac387a98bb7c37292057cffc56d62ecb629900026402633ae9160df93a8766"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[chrono-0.4.38.sha256sum] = "a21f936df1771bf62b77f047b726c4625ff2e8aa607c01ec06e5a05bd8463401"
+SRC_URI[clang-sys-1.7.0.sha256sum] = "67523a3b4be3ce1989d607a828d036249522dd9c1c8de7f4dd2dae43a37369d1"
+SRC_URI[color_quant-1.1.0.sha256sum] = "3d7b894f5411737b7867f4827955924d7c254fc9f4d91a6aad6b097804b1018b"
+SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
+SRC_URI[cpufeatures-0.2.12.sha256sum] = "53fe5e26ff1b7aef8bca9c6080520cfb8d9333c7568e1829cef191a9723e5504"
+SRC_URI[crc32fast-1.4.0.sha256sum] = "b3855a8a784b474f333699ef2bbca9db2c4a1f6d9088a90a2d25b1eb53111eaa"
+SRC_URI[crossbeam-deque-0.8.5.sha256sum] = "613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-utils-0.8.19.sha256sum] = "248e3bacc7dc6baa3b21e405ee045c3047101a49145e7e9eca583ab4c2ca5345"
+SRC_URI[crunchy-0.2.2.sha256sum] = "7a81dae078cea95a014a339291cec439d2f232ebe854a9d672b796c6afafa9b7"
+SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
+SRC_URI[delharc-0.6.1.sha256sum] = "1c93ba2617f5094875af777b3e1e5d66e79d7c832e4ae2e25722c965a482e5a1"
+SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
+SRC_URI[either-1.11.0.sha256sum] = "a47c1c47d2f5964e29c61246e81db715514cd532db6b5116a25ea3c03d6780a2"
+SRC_URI[encoding_rs-0.8.34.sha256sum] = "b45de904aa0b010bce2ab45264d0631681847fa7b6f2eaa7dab7619943bc4f59"
+SRC_URI[enum-primitive-derive-0.2.2.sha256sum] = "c375b9c5eadb68d0a6efee2999fef292f45854c3444c86f09d8ab086ba942b0e"
+SRC_URI[errno-0.3.8.sha256sum] = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"
+SRC_URI[exr-1.72.0.sha256sum] = "887d93f60543e9a9362ef8a21beedd0a833c5d9610e18c67abe15a5963dcb1a4"
+SRC_URI[fastrand-2.1.0.sha256sum] = "9fc0510504f03c51ada170672ac806f1f105a88aa97a5281117e1ddc3368e51a"
+SRC_URI[fdeflate-0.3.4.sha256sum] = "4f9bfee30e4dedf0ab8b422f03af778d9612b63f502710fc500a334ebe2de645"
+SRC_URI[flate2-1.0.30.sha256sum] = "5f54427cfd1c7829e2a139fcefea601bf088ebca651d2bf53ebc600eac295dae"
+SRC_URI[flume-0.11.0.sha256sum] = "55ac459de2512911e4b674ce33cf20befaba382d05b62b008afc1c8b57cbf181"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[gif-0.13.1.sha256sum] = "3fb2d69b19215e18bb912fa30f7ce15846e301408695e44e0ef719f1da9e19f2"
+SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[half-2.4.1.sha256sum] = "6dd08c532ae367adf81c312a4580bc67f1d0fe8bc9c460520283f4c0ff277888"
+SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
+SRC_URI[heck-0.4.1.sha256sum] = "95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
+SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
+SRC_URI[hex-literal-0.4.1.sha256sum] = "6fe2267d4ed49bc07b63801559be28c718ea06c4738b7a03c94df7386d2cde46"
+SRC_URI[home-0.5.9.sha256sum] = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
+SRC_URI[iana-time-zone-0.1.60.sha256sum] = "e7ffbb5a1b541ea2561f8c41c087286cc091e21e556a4f09a8f6cbf17b69b141"
+SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
+SRC_URI[image-0.24.9.sha256sum] = "5690139d2f55868e080017335e4b94cb7414274c74f1669c84fb5feba2c9f69d"
+SRC_URI[indexmap-1.9.3.sha256sum] = "bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
+SRC_URI[inflate-0.4.5.sha256sum] = "1cdb29978cc5797bd8dcc8e5bf7de604891df2a8dc576973d71a281e916db2ff"
+SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
+SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[jpeg-decoder-0.3.1.sha256sum] = "f5d4a7da358eff58addd2877a45865158f0d78c911d43a5784ceb7bbf52833b0"
+SRC_URI[js-sys-0.3.69.sha256sum] = "29c15563dc2726973df627357ce0c9ddddbea194836909d655df6a75d2cf296d"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[lazycell-1.3.0.sha256sum] = "830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
+SRC_URI[lebe-0.5.2.sha256sum] = "03087c2bad5e1034e8cace5926dec053fb3790248370865f5117a7d0213354c8"
+SRC_URI[libc-0.2.155.sha256sum] = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+SRC_URI[libloading-0.8.3.sha256sum] = "0c2a198fb6b0eada2a8df47933734e6d35d350665a33a3593d7164fa52c75c19"
+SRC_URI[linux-raw-sys-0.4.13.sha256sum] = "01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"
+SRC_URI[lock_api-0.4.12.sha256sum] = "07af8b9cdd281b7915f413fa73f29ebd5d55d0d3f0155584dade1ff18cea1b17"
+SRC_URI[log-0.4.21.sha256sum] = "90ed8c1e510134f979dbc4f070f87d4313098b704861a105fe34231c70a3901c"
+SRC_URI[memchr-2.7.2.sha256sum] = "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56c76c1d"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[miniz_oxide-0.7.2.sha256sum] = "9d811f3e15f28568be3407c8e7fdb6514c1cda3cb30683f15b6a1a1dc4ea14a7"
+SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
+SRC_URI[num-complex-0.4.5.sha256sum] = "23c6602fda94a57c990fe0df199a035d83576b496aa29f4e634a8ac6004e68a6"
+SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
+SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
+SRC_URI[paste-1.0.14.sha256sum] = "de3145af08024dea9fa9914f381a17b8fc6034dfb00f3a84013f7ff43f29ed4c"
+SRC_URI[peeking_take_while-0.1.2.sha256sum] = "19b17cddbe7ec3f8bc800887bab5e717348c95ea2ca0b1bf0837fb964dc67099"
+SRC_URI[png-0.17.13.sha256sum] = "06e4b0d3d1312775e782c86c91a111aa1f910cbb65e1337f9975b5f9a554b5e1"
+SRC_URI[prettyplease-0.2.19.sha256sum] = "5ac2cf0f2e4f42b49f5ffd07dae8d746508ef7526c13940e5f524012ae6c6550"
+SRC_URI[primal-check-0.3.3.sha256sum] = "9df7f93fd637f083201473dab4fee2db4c429d32e55e3299980ab3957ab916a0"
+SRC_URI[proc-macro2-1.0.81.sha256sum] = "3d1597b0c024618f09a9c3b8655b7e430397a36d23fdafec26d6965e9eec3eba"
+SRC_URI[qoi-0.4.1.sha256sum] = "7f6d64c71eb498fe9eae14ce4ec935c555749aef511cca85b5568910d6e48001"
+SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[rayon-1.10.0.sha256sum] = "b418a60154510ca1a002a752ca9714984e21e4241e804d32555251faf8b78ffa"
+SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
+SRC_URI[regex-1.10.4.sha256sum] = "c117dbdfde9c8308975b6a18d71f3f385c89461f7b3fb054288ecf2a2058ba4c"
+SRC_URI[regex-automata-0.4.6.sha256sum] = "86b83b8b9847f9bf95ef68afb0b8e6cdb80f498442f5179a29fad448fcc1eaea"
+SRC_URI[regex-syntax-0.8.3.sha256sum] = "adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e179439d1f56"
+SRC_URI[rustc-hash-1.1.0.sha256sum] = "08d43f7aa6b08d49f382cde6a7982047c3426db949b1424bc4b7ec9ae12c6ce2"
+SRC_URI[rustdct-0.7.1.sha256sum] = "8b61555105d6a9bf98797c063c362a1d24ed8ab0431655e38f1cf51e52089551"
+SRC_URI[rustfft-6.2.0.sha256sum] = "43806561bc506d0c5d160643ad742e3161049ac01027b5e6d7524091fd401d86"
+SRC_URI[rustix-0.38.34.sha256sum] = "70dc5ec042f7a43c4a73241207cecc9873a06d45debb38b329f8541d85c2730f"
+SRC_URI[ryu-1.0.17.sha256sum] = "e86697c916019a8588c99b5fac3cead74ec0b4b819707a682fd4d23fa0ce1ba1"
+SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
+SRC_URI[serde-1.0.200.sha256sum] = "ddc6f9cc94d67c0e21aaf7eda3a010fd3af78ebf6e096aa6e2e13c79749cce4f"
+SRC_URI[serde_derive-1.0.200.sha256sum] = "856f046b9400cee3c8c94ed572ecdb752444c24528c035cd35882aad6f492bcb"
+SRC_URI[serde_json-1.0.116.sha256sum] = "3e17db7126d17feb94eb3fad46bf1a96b034e8aacbc2e775fe81505f8b0b2813"
+SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
+SRC_URI[sha2-0.10.8.sha256sum] = "793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
+SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
+SRC_URI[simd-adler32-0.3.7.sha256sum] = "d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
+SRC_URI[smallvec-1.13.2.sha256sum] = "3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
+SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
+SRC_URI[strength_reduce-0.2.4.sha256sum] = "fe895eb47f22e2ddd4dabc02bce419d2e643c8e3b585c78158b349195bc24d82"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.60.sha256sum] = "909518bc7b1c9b779f1bbf07f2929d35af9f0f37e47c6e9ef7f9dddc1e1821f3"
+SRC_URI[tempfile-3.10.1.sha256sum] = "85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
+SRC_URI[thiserror-1.0.59.sha256sum] = "f0126ad08bff79f29fc3ae6a55cc72352056dfff61e3ff8bb7129476d44b23aa"
+SRC_URI[thiserror-impl-1.0.59.sha256sum] = "d1cd413b5d558b4c5bf3680e324a6fa5014e7b7c067a51e69dbdf47eb7148b66"
+SRC_URI[tiff-0.9.1.sha256sum] = "ba1310fcea54c6a9a4fd1aad794ecc02c31682f6bfbecdf460bf19533eed1e3e"
+SRC_URI[tinyvec-1.6.0.sha256sum] = "87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
+SRC_URI[toml-0.5.11.sha256sum] = "f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
+SRC_URI[transpose-0.2.3.sha256sum] = "1ad61aed86bc3faea4300c7aee358b4c6d0c8d6ccc36524c96e4c92ccf26e77e"
+SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[unicode-segmentation-1.11.0.sha256sum] = "d4c87d22b6e3f4a18d4d40ef354e97c90fcb14dd91d7dc0aa9d8a1172ebf7202"
+SRC_URI[uuid-1.8.0.sha256sum] = "a183cf7feeba97b4dd1c0d46788634f6221d87fa961b305bed08c851829efcc0"
+SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+SRC_URI[wasm-bindgen-0.2.92.sha256sum] = "4be2531df63900aeb2bca0daaaddec08491ee64ceecbee5076636a3b026795a8"
+SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] = "614d787b966d3989fa7bb98a654e369c762374fd3213d212cfc0251257e747da"
+SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] = "a1f8823de937b71b9460c0c34e25f3da88250760bec0ebac694b49997550d726"
+SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] = "e94f17b526d0a461a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
+SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] = "af190c94f2773fdb3729c55b007a722abb5384da03bc0986df4c289bf5567e96"
+SRC_URI[weezl-0.1.8.sha256sum] = "53a85b86a771b1c87058196170769dd264f66c0782acf1ae6cc51bfd64b39082"
+SRC_URI[which-4.4.2.sha256sum] = "87ba24419a2078cd2b0f2ede2691b6c66d8e47836da3b6db8265ebad47afbfc7"
+SRC_URI[widestring-1.1.0.sha256sum] = "7219d36b6eac893fa81e84ebe06485e7dcbb616177469b142df14f1f4deb1311"
+SRC_URI[windows-core-0.52.0.sha256sum] = "33ab640c8d7e35bf8ba19b884ba838ceb4fba93a4e8c65a9059d08afcfc683d9"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.52.5.sha256sum] = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
+SRC_URI[windows_aarch64_gnullvm-0.52.5.sha256sum] = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
+SRC_URI[windows_aarch64_msvc-0.52.5.sha256sum] = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
+SRC_URI[windows_i686_gnu-0.52.5.sha256sum] = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
+SRC_URI[windows_i686_gnullvm-0.52.5.sha256sum] = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
+SRC_URI[windows_i686_msvc-0.52.5.sha256sum] = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
+SRC_URI[windows_x86_64_gnu-0.52.5.sha256sum] = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
+SRC_URI[windows_x86_64_gnullvm-0.52.5.sha256sum] = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
+SRC_URI[windows_x86_64_msvc-0.52.5.sha256sum] = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
+SRC_URI[zune-inflate-0.2.54.sha256sum] = "73ab332fe2f6680068f3582b16a24f90ad7096d5d39b974d1c0aff0125116f02"
diff --git a/recipes-scanners/clamav/clamav-git-crates.inc b/recipes-scanners/clamav/clamav-git-crates.inc
new file mode 100644
index 0000000..01237c8
--- /dev/null
+++ b/recipes-scanners/clamav/clamav-git-crates.inc
@@ -0,0 +1,9 @@
+# Git-based Rust dependencies for ClamAV
+# onenote_parser from Cisco-Talos/onenote.rs
+
+SRC_URI += "\
+    git://github.com/Cisco-Talos/onenote.rs.git;protocol=https;nobranch=1;name=onenote_parser;destsuffix=onenote_parser;type=git-dependency \
+"
+
+SRCREV_FORMAT .= "_onenote_parser"
+SRCREV_onenote_parser = "8b450447e58143004b68dd21c11b710fdb79be92"
diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
deleted file mode 100644
index 7b81fd0..0000000
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ /dev/null
@@ -1,156 +0,0 @@
-SUMMARY = "ClamAV anti-virus utility for Unix - command-line interface"
-DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
-HOMEPAGE = "http://www.clamav.net/index.html"
-SECTION = "security"
-LICENSE = "LGPL-2.1-only"
-
-DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck"
- 
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-
-LIC_FILES_CHKSUM = "file://COPYING.txt;beginline=2;endline=3;md5=f7029fbbc5898b273d5902896f7bbe17"
-
-# July 30th, 2022
-SRCREV = "563ba93052f3b7b46fb8725a65ee6299a9c332cf"
-
-SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
-    file://clamd.conf \
-    file://freshclam.conf \
-    file://volatiles.03_clamav \
-    file://tmpfiles.clamav \
-    file://headers_fixup.patch \
-    file://oe_cmake_fixup.patch \
-"
-
-LEAD_SONAME = "libclamav.so"
-SO_VER = "9.6.0"
-
-BINCONFIG = "${bindir}/clamav-config"
-
-inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script
-
-UPSTREAM_CHECK_COMMITS = "1"
-
-CLAMAV_UID ?= "clamav"
-CLAMAV_GID ?= "clamav"
-
-MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
-
-EXTRA_OECMAKE = " -DCMAKE_BUILD_TYPE=Release -DOPTIMIZE=ON -DENABLE_JSON_SHARED=OFF \
-                  -DCLAMAV_GROUP=${CLAMAV_GID} -DCLAMAV_USER=${CLAMAV_UID} \ 
-                  -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=ON \
-                  -DDISABLE_MPOOL=ON -DENABLE_FRESHCLAM_DNS_FIX=ON \
-                   "
-
-PACKAGECONFIG ?= "  clamonacc \
-                 ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
-
-PACKAGECONFIG[milter] = "-DENABLE_MILTER=ON ,-DENABLE_MILTER=OFF, curl, curl"
-PACKAGECONFIG[clamonacc] = "-DENABLE_CLAMONACC=ON ,-DENABLE_CLAMONACC=OFF,"
-PACKAGECONFIG[unrar] = "-DENABLE_UNRAR=ON ,-DENABLE_UNRAR=OFF,"
-PACKAGECONFIG[systemd] = "-DENABLE_SYSTEMD=ON -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir}, -DENABLE_SYSTEMD=OFF, systemd"
-
-export OECMAKE_C_FLAGS += " -I${STAGING_INCDIR} -L ${RECIPE_SYSROOT}${nonarch_libdir} -L${STAGING_LIBDIR} -lpthread" 
-
-do_install:append () {
-    install -d ${D}/${sysconfdir}
-    install -d -o ${PN} -g ${CLAMAV_GID} ${D}/${localstatedir}/lib/clamav
-    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
-
-    install -m 644 ${UNPACKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
-    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
-    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
-    sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
-    rm ${D}/${libdir}/libclamav.so
-    if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
-        install -m 666 ${S}/clamav_db/* ${D}/${localstatedir}/lib/clamav/.
-    fi
-
-    rm ${D}/${libdir}/libfreshclam.so
-
-    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
-        install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
-    fi
-    oe_multilib_header clamav-types.h
-}
-
-pkg_postinst:${PN} () {
-    if [ -z "$D" ]; then
-        if command -v systemd-tmpfiles >/dev/null; then
-            systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/clamav.conf
-        elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
-            ${sysconfdir}/init.d/populate-volatile.sh update
-        fi
-    fi
-}
-
-PACKAGES += "${PN}-daemon ${PN}-clamdscan ${PN}-freshclam ${PN}-libclamav"
-
-FILES:${PN} = "${bindir}/clambc ${bindir}/clamscan ${bindir}/clamsubmit ${sbindir}/clamonacc \
-                ${bindir}/*sigtool ${mandir}/man1/clambc* ${mandir}/man1/clamscan* \
-                ${mandir}/man1/sigtool* ${mandir}/man1/clambsubmit*  \
-                ${docdir}/clamav/*"
-
-FILES:${PN}-clamdscan = " ${bindir}/clamdscan \
-                        ${docdir}/clamdscan/* \
-                        ${mandir}/man1/clamdscan* \
-                        "
-
-FILES:${PN}-daemon = "${bindir}/clamconf ${bindir}/clamdtop ${sbindir}/clamd \
-                        ${mandir}/man1/clamconf* ${mandir}/man1/clamdtop* \
-                        ${mandir}/man5/clamd*  ${mandir}/man8/clamd* \
-                        ${sysconfdir}/clamd.conf* \
-                        /usr/etc/clamd.conf* \
-                        ${systemd_system_unitdir}/clamav-daemon/* \
-                        ${docdir}/clamav-daemon/*  ${sysconfdir}/clamav-daemon \
-                        ${sysconfdir}/logcheck/ignore.d.server/clamav-daemon \
-                        ${systemd_system_unitdir}/clamav-daemon.service \
-                        ${systemd_system_unitdir}/clamav-clamonacc.service \
-                        "
-
-FILES:${PN}-freshclam = "${bindir}/freshclam \
-                        ${sysconfdir}/freshclam.conf*  \
-                        /usr/etc/freshclam.conf*  \
-                        ${sysconfdir}/clamav ${sysconfdir}/default/volatiles \
-                        ${sysconfdir}/tmpfiles.d/*.conf \
-                        ${localstatedir}/lib/clamav \
-                        ${docdir}/${PN}-freshclam ${mandir}/man1/freshclam.* \
-                        ${mandir}/man5/freshclam.conf.* \
-                        ${systemd_system_unitdir}/clamav-freshclam.service"
-
-FILES:${PN}-dev = " ${bindir}/clamav-config ${libdir}/*.la \
-                    ${libdir}/pkgconfig/*.pc \
-                    ${mandir}/man1/clamav-config.* \
-                    ${includedir}/*.h ${docdir}/libclamav* \
-                    ${libdir}/libmspack.so"
-
-FILES:${PN}-staticdev = "${libdir}/*.a"
-
-FILES:${PN}-libclamav = "${libdir}/libclamav.so* ${libdir}/libclammspack.so* \
-                         ${libdir}/libfreshclam.so* ${docdir}/libclamav/* \
-                         ${libdir}/libmspack* "
-
-FILES:${PN}-doc = "${mandir}/man/* \
-                   ${datadir}/man/* \
-                   ${docdir}/* "
-
-USERADD_PACKAGES = "${PN}-freshclam "
-GROUPADD_PARAM:${PN}-freshclam = "--system ${CLAMAV_UID}"
-USERADD_PARAM:${PN}-freshclam = "--system -g ${CLAMAV_GID} --home-dir  \
-    ${localstatedir}/lib/${BPN} \
-    --no-create-home  --shell /sbin/nologin ${PN}"
-
-RPROVIDES:${PN} += "${PN}-systemd"
-RREPLACES:${PN} += "${PN}-systemd"
-RCONFLICTS:${PN} += "${PN}-systemd"
-SYSTEMD_PACKAGES  = "${PN}-daemon ${PN}-freshclam"
-SYSTEMD_SERVICE:${PN}-daemon = "clamav-daemon.service"
-SYSTEMD_SERVICE:${PN}-freshclam = "clamav-freshclam.service"
-
-INSANE_SKIP:${PN}-libclamav  += "dev-so"
-
-RDEPENDS:${PN} = "openssl ncurses-libncurses libxml2 libbz2 ncurses-libtinfo curl libpcre2 clamav-libclamav"
-RRECOMMENDS:${PN} = "clamav-freshclam"
-RDEPENDS:${PN}-freshclam = "clamav"
-RDEPENDS:${PN}-daemon = "clamav clamav-freshclam"
diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
new file mode 100644
index 0000000..638779f
--- /dev/null
+++ b/recipes-scanners/clamav/clamav_1.4.3.bb
@@ -0,0 +1,238 @@
+SUMMARY = "ClamAV anti-virus utilities and scanner tools"
+DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
+HOMEPAGE = "http://www.clamav.net/index.html"
+SECTION = "security"
+LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
+LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
+                    file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
+                    file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
+                    file://COPYING/COPYING.zlib;md5=3648a0b9713ab246e11536055165a41a \
+                    file://COPYING/COPYING.llvm;md5=c82fc668ef1809acdd0684811df93bfc \
+                    file://COPYING/COPYING.unrar;md5=6a741ba21afc8b71aeaee3b5f86a8111 \
+                    file://COPYING/COPYING.file;md5=e63a61022c36cff2fdfbf02dd51674bd \
+                    file://COPYING/COPYING.curl;md5=be5d9e1419c4363f4b32037a2d3b7ffa \
+                    "
+
+DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native libmspack"
+
+SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
+           file://clamd.conf \
+           file://freshclam.conf \
+           file://volatiles.03_clamav \
+           file://tmpfiles.clamav \
+           "
+
+# ClamAV version 1.4.3
+SRCREV = "d8b053865fd5995f7af98bfbcd98c9a5644bfe2b"
+
+COMPATIBLE_HOST:libc-musl:class-target = "null"
+
+LEAD_SONAME = "libclamav.so"
+SO_VER = "12.0.0"
+BINCONFIG = "${bindir}/clamav-config"
+
+inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script cargo cargo-update-recipe-crates
+
+# Rust code is in libclamav_rust subdirectory
+CARGO_SRC_DIR = "libclamav_rust"
+# Cargo.lock is in the root directory
+CARGO_LOCK_PATH = "${S}/Cargo.lock"
+
+require ${BPN}-crates.inc
+require ${BPN}-git-crates.inc
+
+UPSTREAM_CHECK_COMMITS = "1"
+
+CLAMAV_USER ?= "clamav"
+CLAMAV_GROUP ?= "clamav"
+
+PACKAGECONFIG ?= "clamonacc \
+                  ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
+PACKAGECONFIG[milter] = "-DENABLE_MILTER=ON ,-DENABLE_MILTER=OFF, curl, curl"
+PACKAGECONFIG[clamonacc] = "-DENABLE_CLAMONACC=ON ,-DENABLE_CLAMONACC=OFF,"
+PACKAGECONFIG[unrar] = "-DENABLE_UNRAR=ON ,-DENABLE_UNRAR=OFF,"
+PACKAGECONFIG[freshclamdnsfix] = "-DENABLE_FRESHCLAM_DNS_FIX=ON ,-DENABLE_FRESHCLAM_DNS_FIX=OFF,"
+PACKAGECONFIG[systemd] = "-DENABLE_SYSTEMD=ON -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir}, -DENABLE_SYSTEMD=OFF, systemd"
+
+EXTRA_OECMAKE = "-DCMAKE_BUILD_TYPE=Release -DOPTIMIZE=ON -DENABLE_JSON_SHARED=OFF \
+                 -DCLAMAV_GROUP=${CLAMAV_GROUP} -DCLAMAV_USER=${CLAMAV_USER} \
+                 -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=ON \
+                 -DDO_NOT_SET_RPATH=ON \
+                 -DCMAKE_INSTALL_PREFIX=${prefix} \
+                 -DCMAKE_INSTALL_SYSCONFDIR=${sysconfdir} \
+                 -DCMAKE_INSTALL_FULL_SYSCONFDIR=${sysconfdir} \
+                 -DSYSCONFDIR=${sysconfdir} \
+                 -DAPP_CONFIG_DIRECTORY=${sysconfdir}/clamav \
+                 -DHAVE_SIGNED_RIGHT_SHIFT=1 \
+                 -DHAVE_UNAME_SYSCALL=1 \
+                 -DHAVE_FD_PASSING=1 \
+                 -Dtest_run_result=0 \
+                 -Dtest_run_result__TRYRUN_OUTPUT='' \
+                 -DCMAKE_C_FLAGS='${CFLAGS} -Wno-error=format-truncation -Wno-error=unused-function' \
+                 "
+
+MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
+
+# ClamAV uses both CMake and Rust/Cargo, so we need to configure both
+do_configure() {
+    cmake_do_configure
+    cargo_common_do_configure
+}
+
+# Override do_compile to handle CMake build separately from Cargo
+do_compile() {
+    # Build with CMake (this will also trigger the Rust build via CMake)
+    cmake_do_compile
+}
+
+do_compile:append() {
+    # Remove build path references from Rust static library
+    ${OBJCOPY} --remove-section .debug_line ${B}/libclamav_rust/target/${RUST_TARGET_SYS}/release/libclamav_rust.a || true
+}
+
+# Override do_install to use CMake install (Rust library is statically linked, no separate install needed)
+do_install() {
+    # Install with CMake
+    cmake_do_install
+}
+
+do_install:append() {
+    install -d ${D}/${sysconfdir}
+    install -d ${D}/${localstatedir}/lib/clamav
+    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
+
+    install -m 644 ${UNPACKDIR}/clamd.conf ${D}${sysconfdir}/clamav
+    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}${sysconfdir}/clamav
+    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
+
+    if [ -d ${D}${prefix}/etc ]; then
+        cp -r ${D}${prefix}/etc/* ${D}${sysconfdir}/ 2>/dev/null || true
+        rm -rf ${D}${prefix}/etc
+    fi
+
+    sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
+
+    # Remove build path references from binaries
+    chrpath -d ${D}${bindir}/clambc || true
+    chrpath -d ${D}${bindir}/sigtool || true
+    chrpath -d ${D}${libdir}/libclamav.so.${SO_VER} || true
+    chrpath -d ${D}${libdir}/libfreshclam.so.* || true
+
+    rm ${D}/${libdir}/libclamav.so
+    if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
+        install -m 666 ${S}/clamav_db/* ${D}/${localstatedir}/lib/clamav/.
+    fi
+
+    rm ${D}/${libdir}/libfreshclam.so
+
+    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
+        install -d ${D}${sysconfdir}/tmpfiles.d
+        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
+    fi
+    oe_multilib_header clamav-types.h
+}
+
+pkg_postinst:${PN} () {
+    if [ -n "$D" ]; then
+        return 0
+    fi
+
+    if command -v systemd-tmpfiles >/dev/null; then
+        systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/clamav.conf
+    elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
+        ${sysconfdir}/init.d/populate-volatile.sh update
+    fi
+}
+
+pkg_postinst:${PN}-freshclam () {
+    if [ -n "$D" ]; then
+        return 0
+    fi
+
+    # Ensure correct ownership on directories (volatiles may not fix existing dirs)
+    if [ -d ${localstatedir}/lib/clamav ]; then
+        chown -R ${CLAMAV_USER}:${CLAMAV_GROUP} ${localstatedir}/lib/clamav
+    fi
+    if [ -d ${localstatedir}/log/clamav ]; then
+        chown -R ${CLAMAV_USER}:${CLAMAV_GROUP} ${localstatedir}/log/clamav
+    fi
+}
+
+PACKAGES += "${PN}-daemon ${PN}-clamdscan ${PN}-freshclam ${PN}-libclamav ${PN}-libclammspack"
+
+FILES:${PN} = "${bindir}/clambc ${bindir}/clamscan ${bindir}/clamsubmit ${sbindir}/clamonacc \
+               ${bindir}/*sigtool ${mandir}/man1/clambc* ${mandir}/man1/clamscan* \
+               ${mandir}/man1/sigtool* ${mandir}/man1/clambsubmit* \
+               ${docdir}/clamav/*"
+
+FILES:${PN}-clamdscan = "${bindir}/clamdscan \
+                         ${docdir}/clamdscan/* \
+                         ${mandir}/man1/clamdscan* \
+                         "
+
+FILES:${PN}-daemon = "${bindir}/clamconf ${bindir}/clamdtop ${sbindir}/clamd \
+                      ${mandir}/man1/clamconf* ${mandir}/man1/clamdtop* \
+                      ${mandir}/man5/clamd* ${mandir}/man8/clamd* \
+                      ${sysconfdir}/clamav/clamd.conf* \
+                      ${systemd_system_unitdir}/clamav-daemon/* \
+                      ${docdir}/clamav-daemon/* ${sysconfdir}/clamav-daemon \
+                      ${sysconfdir}/logcheck/ignore.d.server/clamav-daemon \
+                      ${systemd_system_unitdir}/clamav-daemon.service \
+                      ${systemd_system_unitdir}/clamav-clamonacc.service \
+                      "
+
+FILES:${PN}-freshclam = "${bindir}/freshclam \
+                         ${sysconfdir}/clamav/freshclam.conf* \
+                         ${sysconfdir}/clamav ${sysconfdir}/default/volatiles \
+                         ${sysconfdir}/tmpfiles.d/*.conf \
+                         ${localstatedir}/lib/clamav \
+                         ${docdir}/${PN}-freshclam ${mandir}/man1/freshclam.* \
+                         ${mandir}/man5/freshclam.conf.* \
+                         ${systemd_system_unitdir}/clamav-freshclam.service"
+
+FILES:${PN}-libclamav = "${libdir}/libclamav.so* \
+                         ${libdir}/libfreshclam.so* ${docdir}/libclamav/* \
+                         "
+
+FILES:${PN}-libclammspack = "${libdir}/libclammspack.so* \
+                             ${libdir}/libmspack.so* \
+                             "
+
+FILES:${PN}-dev = "${bindir}/clamav-config ${libdir}/*.la \
+                   ${libdir}/pkgconfig/*.pc \
+                   ${mandir}/man1/clamav-config.* \
+                   ${includedir}/*.h ${docdir}/libclamav*"
+
+FILES:${PN}-staticdev = "${libdir}/*.a"
+
+FILES:${PN}-doc = "${mandir}/man/* \
+                   ${datadir}/man/* \
+                   ${docdir}/* \
+                   "
+
+RDEPENDS:${PN} = "openssl ncurses-libncurses libxml2 libbz2 ncurses-libtinfo curl libpcre2 clamav-libclamav"
+RDEPENDS:${PN}-daemon = "clamav clamav-freshclam"
+RDEPENDS:${PN}-freshclam = "clamav"
+RDEPENDS:${PN}-libclamav = "clamav-libclammspack"
+
+RRECOMMENDS:${PN} = "clamav-freshclam"
+
+RPROVIDES:${PN} += "${PN}-systemd"
+RREPLACES:${PN} += "${PN}-systemd"
+RCONFLICTS:${PN} += "${PN}-systemd"
+
+SYSTEMD_PACKAGES = "${PN}-daemon ${PN}-freshclam"
+SYSTEMD_SERVICE:${PN}-daemon = "clamav-daemon.service"
+SYSTEMD_SERVICE:${PN}-freshclam = "clamav-freshclam.service"
+
+USERADD_PACKAGES = "${PN}-freshclam"
+GROUPADD_PARAM:${PN}-freshclam = "--system ${CLAMAV_GROUP}"
+USERADD_PARAM:${PN}-freshclam = "--system -g ${CLAMAV_GROUP} --home-dir \
+                                 ${localstatedir}/lib/${BPN} \
+                                 --no-create-home --shell /sbin/nologin ${CLAMAV_USER}"
+
+INSANE_SKIP:${PN}-libclamav += "dev-so"
+INSANE_SKIP:${PN}-libclammspack += "dev-so"
+INSANE_SKIP:${PN} += "buildpaths"
+INSANE_SKIP:${PN}-libclamav += "buildpaths"
+INSANE_SKIP:${PN}-staticdev += "buildpaths"
diff --git a/recipes-scanners/clamav/files/headers_fixup.patch b/recipes-scanners/clamav/files/headers_fixup.patch
deleted file mode 100644
index 369aa58..0000000
--- a/recipes-scanners/clamav/files/headers_fixup.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-Fixes checks not needed do to glibc 2.33
-
-Upstream-Status: Pending
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/CMakeLists.txt
-===================================================================
---- git.orig/CMakeLists.txt
-+++ git/CMakeLists.txt
-@@ -443,8 +443,6 @@ check_include_file("stdlib.h"
- check_include_file("string.h"           HAVE_STRING_H)
- check_include_file("strings.h"          HAVE_STRINGS_H)
- check_include_file("sys/cdefs.h"        HAVE_SYS_CDEFS_H)
--check_include_file("sys/dl.h"           HAVE_SYS_DL_H)
--check_include_file("sys/fileio.h"       HAVE_SYS_FILIO_H)
- check_include_file("sys/mman.h"         HAVE_SYS_MMAN_H)
- check_include_file("sys/param.h"        HAVE_SYS_PARAM_H)
- check_include_file("sys/queue.h"        HAVE_SYS_QUEUE_H)
-@@ -479,8 +477,6 @@ endif()
- 
- # int-types variants
- check_include_file("inttypes.h"         HAVE_INTTYPES_H)
--check_include_file("sys/inttypes.h"     HAVE_SYS_INTTYPES_H)
--check_include_file("sys/int_types.h"    HAVE_SYS_INT_TYPES_H)
- check_include_file("stdint.h"           HAVE_STDINT_H)
- 
- # this hack required to silence warnings on systems with inttypes.h
-@@ -608,17 +604,11 @@ check_type_size("time_t"  SIZEOF_TIME_T)
- # Checks for library functions.
- include(CheckSymbolExists)
- check_symbol_exists(_Exit           "stdlib.h"      HAVE__EXIT)
--check_symbol_exists(accept4         "sys/types.h"   HAVE_ACCEPT4)
- check_symbol_exists(snprintf        "stdio.h"       HAVE_SNPRINTF)
--check_symbol_exists(stat64          "sys/stat.h"    HAVE_STAT64)
--check_symbol_exists(strcasestr      "string.h"      HAVE_STRCASESTR)
- check_symbol_exists(strerror_r      "string.h"      HAVE_STRERROR_R)
--check_symbol_exists(strlcat         "string.h"      HAVE_STRLCAT)
--check_symbol_exists(strlcpy         "string.h"      HAVE_STRLCPY)
- check_symbol_exists(strndup         "string.h"      HAVE_STRNDUP)
- check_symbol_exists(strnlen         "string.h"      HAVE_STRNLEN)
--check_symbol_exists(strnstr         "string.h"      HAVE_STRNSTR)
--check_symbol_exists(sysctlbyname    "sysctl.h"      HAVE_SYSCTLBYNAME)
-+check_symbol_exists(strcasecmp      "string.h"      HAVE_STRNCMP)
- check_symbol_exists(timegm          "time.h"        HAVE_TIMEGM)
- check_symbol_exists(vsnprintf       "stdio.h"       HAVE_VSNPRINTF)
- 
-@@ -632,10 +622,9 @@ else()
-     check_symbol_exists(fseeko          "stdio.h"       HAVE_FSEEKO)
-     check_symbol_exists(getaddrinfo     "netdb.h"       HAVE_GETADDRINFO)
-     check_symbol_exists(getpagesize     "unistd.h"      HAVE_GETPAGESIZE)
--    check_symbol_exists(mkstemp         "unistd.h"      HAVE_MKSTEMP)
-     check_symbol_exists(poll            "poll.h"        HAVE_POLL)
--    check_symbol_exists(setgroups       "unistd.h"      HAVE_SETGROUPS)
-     check_symbol_exists(setsid          "unistd.h"      HAVE_SETSID)
-+    set(HAVE_SYSCONF_SC_PAGESIZE 1)
- endif()
- 
- include(CheckSymbolExists)
diff --git a/recipes-scanners/clamav/files/oe_cmake_fixup.patch b/recipes-scanners/clamav/files/oe_cmake_fixup.patch
deleted file mode 100644
index c9c88b9..0000000
--- a/recipes-scanners/clamav/files/oe_cmake_fixup.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-Issue with rpath including /usr/lib and crosscompile checkes causing oe configure to fail
-
-Use oe's cmake rpath framework and exclude some of the cmake checks that fail in our env
-
-Upstream-Status: Inappropriate [configuration]
-Singed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/CMakeLists.txt
-===================================================================
---- git.orig/CMakeLists.txt
-+++ git/CMakeLists.txt
-@@ -162,12 +162,6 @@ endif()
- 
- include(GNUInstallDirs)
- 
--if(CMAKE_INSTALL_FULL_LIBDIR)
--    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
--else()
--    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
--endif()
--
- if(C_LINUX)
-     if(CMAKE_COMPILER_IS_GNUCXX)
-         # Set _GNU_SOURCE for O_LARGEFILE, O_CLOEXEC, O_DIRECTORY, O_NOFOLLOW, etc flags on older systems
-@@ -581,14 +575,8 @@ include(TestInline)
- include(CheckFileOffsetBits)
- # Determine how to pack structs on this platform.
- include(CheckStructPacking)
--# Check for signed right shift implementation.
--include(CheckSignedRightShift)
- # Check if systtem fts implementation available
- include(CheckFTS)
--# Check if uname(2) follows POSIX standard.
--include(CheckUnamePosix)
--# Check support for file descriptor passing
--include(CheckFDPassing)
- 
- # Check if big-endian
- include(TestBigEndian)
diff --git a/recipes-scanners/clamav/files/tmpfiles.clamav b/recipes-scanners/clamav/files/tmpfiles.clamav
index fd5adfe..8e0849e 100644
--- a/recipes-scanners/clamav/files/tmpfiles.clamav
+++ b/recipes-scanners/clamav/files/tmpfiles.clamav
@@ -1,3 +1,4 @@
 #Type Path        Mode UID  GID  Age Argument
+d /var/lib/clamav 0755 clamav clamav -
 d /var/log/clamav 0755 clamav clamav -
 f /var/log/clamav/freshclam.log 0644 clamav clamav -
diff --git a/recipes-scanners/clamav/files/volatiles.03_clamav b/recipes-scanners/clamav/files/volatiles.03_clamav
index ee2153c..0561c4d 100644
--- a/recipes-scanners/clamav/files/volatiles.03_clamav
+++ b/recipes-scanners/clamav/files/volatiles.03_clamav
@@ -1,3 +1,4 @@
 # <type> <owner> <group> <mode> <path> <linksource>
+d clamav clamav 0755 /var/lib/clamav none
 d clamav clamav 0755 /var/log/clamav none
 f clamav clamav 0655 /var/log/clamav/freshclam.log none
-- 
2.43.0



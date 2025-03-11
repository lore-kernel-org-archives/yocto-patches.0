Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58314C35FF1
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:50 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.web10.6512.1741692404536409175
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBs0g11KMzvPF;
	Tue, 11 Mar 2025 12:26:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBs0f5c0yz65y;
	Tue, 11 Mar 2025 12:26:42 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 11 Mar 2025 12:26:33 +0100
Subject: [meta-rockchip PATCH 4/6] bsp: rkbin: ddr: allow to customize DDR
 bin blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-ddrbin-custom-v1-4-e5c994ac25e1@cherry.de>
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
In-Reply-To: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 11:26:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1186

From: Quentin Schulz <quentin.schulz@cherry.de>

Rockchip provides a tool to customize the DDR bin blob which can prove
to be extremely useful, for example if your HW doesn't follow the HW
reference design and uses a different UART controller or UART mux for
the serial console, or use a different baudrate.

If RKBIN_DDR_RECONFIGURE is set to 1 for a machine, a ddrbin_params.txt
needs to be provided for said machine and ddrbin_tool.py will be run
against it to generate a new custom binary with the desired config.

Note that future implementations may allow to provide configuration
through a different mechanism than a simple and difficult to
maintain/modify file. E.g. this doesn't really work well when one wants
to have this in sync with SERIAL_CONSOLES for example. But that may be
much harder to support as the serial controller index in
SERIAL_CONSOLES does not necessarily match the hardware index expected
by ddrbin_params.txt. It also doesn't provide the UART mux.

In any case, I believe this is a decent start at allowing customization
of the DDR bin blob without having to provide a blob directly in-tree.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README                                      | 20 ++++++++++++-
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 44 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 6bceba0c9cf09cc0fc881c855fabeeb68aeb55fb..567d7ed8c5dd37c3c796acb869b85c25ad548a15 100644
--- a/README
+++ b/README
@@ -55,7 +55,7 @@ Status of supported boards:
 
 Notes:
 -----
-  Custom DDR rkbin version:
+  Customize DDR rkbin:
 	If you wish to use a different version of DDR binary provided by
 	rockchip-rkbin-ddr recipe than the one in this layer, you can create a
 	.bbappend in your own layer, and accordingly set SRCREV (possibly
@@ -70,6 +70,24 @@ Notes:
 		DDRBIN_VERS:my-machine = "v2.07"
 		DDRBIN_FILE:my-machine = "rk3308_ddr_451MHz_uart4_m0_${DDRBIN_VERS}.bin"
 
+	If you wish to use a configuration for the DDR binary blob provided in
+	rockchip-rkbin-ddr recipe that differs from the default, you can set the
+	RKBIN_DDR_RECONFIGURE variable to 1 for your machine, e.g.:
+
+		RKBIN_DDR_RECONFIGURE:my-machine = "1"
+
+	You will need to provide your custom ddrbin_params.txt via your bbappend, e.g.
+	your ddrbin_params in
+	meta-my-layer/recipes-bsp/rkbin/rockchip-rkbin-ddr/my-machine/ddrbin_params.txt
+	and a bbappend, e.g. in meta-my-layer/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bbappend,
+	which contains:
+
+		FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+	As for the content of ddrbin_params.txt,
+	https://github.com/rockchip-linux/rkbin/blob/master/tools/ddrbin_tool_user_guide.txt
+	may help.
+
   rk3308 rkbin:
 	The latest ddr initializer for the rk3308 platform does not output
 	diagnostic messages to uart0. This causes a bunch of gibberish to
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 546560cf58b0480efd0f89ff21639c7b78f70530..193d0f00a6868f050a0ff4531278b3296d3eae94 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -6,6 +6,7 @@ DDRBIN_DIR:rk3308 ?= "bin/rk33/"
 DDRBIN_VERS:rk3308 ?= "v2.10"
 DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
+DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
 
 do_deploy:rk3308() {
 	# Prebuilt U-Boot TPL (DDR init)
@@ -16,6 +17,7 @@ DDRBIN_DIR:rk3566 ?= "bin/rk35/"
 DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
+DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
 
 do_deploy:rk3566() {
 	# Prebuilt U-Boot TPL (DDR init)
@@ -26,6 +28,7 @@ DDRBIN_DIR:rk3568 ?= "bin/rk35/"
 DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
+DDRBIN_TOOL_SOC:rk3568 ?= "rk356x"
 
 do_deploy:rk3568() {
 	# Prebuilt U-Boot TPL (DDR init)
@@ -36,8 +39,49 @@ DDRBIN_DIR:rk3588s ?= "bin/rk35/"
 DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
+DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
 
 do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
 	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }
+
+# The following is only required if DDR bin blob needs to be modified
+# (e.g. different UART controller, UART mux, or baudrate)
+# RKBIN_DDR_RECONFIGURE = "1" if it needs to be modified, all below logic needs to
+# depend on that value be 1, and not run if 0.
+RKBIN_DDR_RECONFIGURE ?= "0"
+
+# The tool (ddrbin_tool.py) for modifying the DDR bin is from rockchip-rkbin-native...
+DEPENDS += "${@'rockchip-rkbin-native' if d.getVar('RKBIN_DDR_RECONFIGURE') == '1' else ''}"
+
+# ... and it expects a file as input, which is named ddrbin_params.txt in the tree.
+SRC_URI += "${@'file://ddrbin_params.txt' if d.getVar('RKBIN_DDR_RECONFIGURE') == '1' else ''}"
+
+python __anonymous() {
+    # Because rockchip-rkbin.inc inherits bin_package and we need to run some step before
+    # the install task re-enable do_configure task.
+    # We could use
+    #  do_configure[noexec] = "${@'0' if d.getVar('RKBIN_DDR_RECONFIGURE') == '1' else '1'}"
+    # but this spams the console with deprecation warnings, see
+    # https://bugzilla.yoctoproject.org/show_bug.cgi?id=13808
+    if d.getVar('RKBIN_DDR_RECONFIGURE') == '1':
+        d.delVarFlag("do_configure", "noexec")
+}
+
+do_configure() {
+	if [ "${RKBIN_DDR_RECONFIGURE}" = "1" ]; then
+		# ddrbin_tool.py always modifies a date in the DDR blob, based on current time.
+		# This is bad for reproducibility and hashequiv usage, so use the commit author
+		# date of the last change made to the DDR bin.
+		# DATE must be max 17-character long!
+		RKBIN_DDR_DATE=$(git log --pretty=format:"%ad" --date=format:"%Y%m%d-%H:%M:%S" -1 -- ${S}/${DDRBIN_DIR}${DDRBIN_FILE})
+		# DDRBIN_TOOL_SOC is mostly useless except for rk3528 for now. It needs to match one string in the global
+		# chip_list array in ddrbin_tool.py.
+		if [ -z "${DDRBIN_TOOL_SOC}" ]; then
+			bbfatal "Non-empty DDRBIN_TOOL_SOC:<MACHINE> required!"
+		fi
+		# Modify blob with appropriate settings stored in ddrbin_params.txt
+		ddrbin_tool.py ${DDRBIN_TOOL_SOC} ${UNPACKDIR}/ddrbin_params.txt ${S}/${DDRBIN_DIR}${DDRBIN_FILE} --verinfo_editable "${RKBIN_DDR_DATE}"
+	fi
+}

-- 
2.48.1



Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E2D43357
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 21:03:43 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1054.1765487018419758604
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 13:03:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hi6TdG0d;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2d56eaaceso57415485a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765487017; x=1766091817; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bxE7O7+Hf74DbEksdyb+hz44qHXPRwKSdVoKzWKYaI=;
        b=Hi6TdG0dwn4yAX8bbFW1unirb2R8iwwSdXNAy/URaenpa1gZsHCj74JmQymf5PcMsh
         aAW8qW7CkB7ILxNVcC4RwTdFZg0yfnNgu5g4BVrs03yjNV1NXtIgyoh+s4+ZHfTDjKSj
         SAyNCTrNADHT0uP4DPOHaqM9vJsxN9qPtdmkxTODP1DnSKD6zDzDbmMzPEoneOcXktcF
         IIuZ+wRG+JFCfafRGbkAJAlUpG6/NKRXvpJZ22kxNIGKL/zOPuJloeRYdgB+PfmP/ocp
         EpfAuSP4z5Gc7GpHQVJQivkrTmKsCRm62J0jf5h3gFbTrtnbeCmMwwFNPtsTljmru4xS
         jSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765487017; x=1766091817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bxE7O7+Hf74DbEksdyb+hz44qHXPRwKSdVoKzWKYaI=;
        b=UxtTOgBWqLz7UT18iCAg6CqlkrherKl6n3HGCRIy5wEH1bhpFDoHIJBJNRXj66XD8U
         MPKUqh7qsWencuNzICRzv38JBvJMfIivdIyteYVY6FjyLIM5u4MfsgpG3/F0gSrSzYI6
         vijdy4wdh2TVy9CQ4JEujFu532JIdDoNFvFKWJCOTYGUr4souF2KVVn4tvZr2o7jAoxR
         K7VmWAYydEtNVuRRR8mw1WFoH7yWvQwqrxWgjcph5pHRrHjgeCYq0wE1OwU4ePjKn40D
         emhecpALB9T3G+Gkrplk7/KzZDProIllJWAuC5mU0dWQkQtwMtKp8ZA3Ym7PK4+H5GTL
         AeBw==
X-Gm-Message-State: AOJu0YxCt6oG9piaJTbsC/Qg6Z7/h6zB6H7/sJQRsyByaoaDNp2WY+G5
	NZWRXdc4IBkjAIOKhblHujpxyzQZrqc823uZ4GHDV9sS8nx43DqFFz3K7QlZWw==
X-Gm-Gg: AY/fxX6PYGIsjieH0X4CgPNXaW2fRoEKt/+KRkpwsPcAMV6kHoY7SQBALkOlw5zTt8Q
	W1ygRsjfApgLBlM6X+w3sDjVJcpejLXLiPGAkqaj37hCcILo5ocbrMwM58q6tqp/PKiKE6PTVst
	VWHxs/dbol19b7PnDGj4ElNeSsBMAYkRIV4L1D1nDqEidsB3Cbt3O0X7Q/RrYv6hc7gYlOY63Tp
	KcPRyQiwtSWxw0J0lV8OEIWKli5lF9x4tCSS1/fjEsJecO5XTBhOsipUJEZhf0jsyJO/nsovQCK
	hGZPcKloxWRg76awkMcL4tOLfGimaY3buHCxbvV3xp/em/8bV4OwAEQkkbPNfUaxutCFNTqqAHE
	TwTqXqQhqNffQV0xyYQ/ob2DEkn5KTKUqc9SozO8VKhOMGECxxME15s6Xf8bJBGC/UO/aZoWw66
	/BebbrX4XwIJTDDmqZhg/LERbYLHfndQhbyZUViQ==
X-Google-Smtp-Source: AGHT+IFkxYHnD4UhWerrekFO+DQ/bc5QagiitIRmD0vsLHJD2wHFUZtIXmWEwl9k81C/DopVeGKZZQ==
X-Received: by 2002:a05:620a:8e87:b0:8ba:af6e:10d3 with SMTP id af79cd13be357-8baaf6e112emr488134685a.30.1765487016589;
        Thu, 11 Dec 2025 13:03:36 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5452cfbsm306582685a.5.2025.12.11.13.03.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 13:03:35 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] provide a filesystem overlay example
Date: Thu, 11 Dec 2025 16:03:32 -0500
Message-ID: <20251211210332.25509-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 21:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2769

Most implementations that use an A/B, full-partition update mechanism
(such as RAUC configured for this scenario) need some way of preserving
system configurations in a location that survives updates. The RAUC demo
provided in this layer is an example of a full-partition update,
therefore provide an example of using a filesystem overlay to preserve
system configurations. This example is gated by a configuration knob:

	RK_OVERLAY_DEMO

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README                                        | 28 +++++++++++++++++++
 conf/machine/include/rockchip-rauc.inc        |  1 +
 .../systemd/data-partition-overlay_1.0.bb     | 22 +++++++++++++++
 .../recipes-core/systemd/files/etc.mount      | 13 +++++++++
 .../recipes-core/systemd/files/home.mount     | 13 +++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount

diff --git a/README b/README
index 6a13428d488d..92dc072a0833 100644
--- a/README
+++ b/README
@@ -140,6 +140,34 @@ Notes:
 	this layer, perform the same steps as above except for the step enabling
 	RK_RAUC_DEMO.
 
+  /data overlay with RAUC
+	When using RAUC for whole-partition rootfs updates, you will need some
+	way of preserving some pieces of data between updates; this is why the
+	DEMO scheme provided in this layer also includes a /data partition.
+	Now that you have a /data partition that is not updated, you need some
+	way of storing your important data there and making it available,
+	seamlessly, into your system regardless of which slot is running.
+
+	One way of accomplishing this is to move your important files into
+	/data and providing symlinks back into each running bundle. But that
+	requires you to know ahead of time which files will be touched... which
+	quickly can become a game of whack-a-mole. A better alternative is to
+	use a filesystem overlay. With a filesystem overlay, multiple paths are
+	overlaid on top of each other behind the scenes so what you see is one
+	directory containing the aggregation of all layers. Filesystem overlays
+	have a concept of "bottom layers" and "upper layers", if you write a new
+	file into an overlay, the file will be written into the uppermost
+	layer, leaving the lower layers intact. If a file is modified, the
+	modifications are stored in the upper layer, occluding the lower layer.
+	Therefore, creating an overlay using locations in the /data partition
+	as the uppermost layer allows changes to persist across RAUC updates.
+
+	This layer includes a simple overlay scheme to demonstrate one way of
+	making use of this mechanism. To enable the demo included in this layer
+	RAUC must be enabled, then also enable:
+
+		RK_OVERLAY_DEMO
+
   HW video decoding with gstreamer
 
 	Most Rockchip SoCs have some integrated VPU, either Hantro, RKVDEC or
diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
index a6f79503076b..3ea95298fed6 100644
--- a/conf/machine/include/rockchip-rauc.inc
+++ b/conf/machine/include/rockchip-rauc.inc
@@ -2,3 +2,4 @@
 # rauc demo configuration from this layer
 OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
 IMAGE_INSTALL:append:rk-rauc-demo = " abd-partition"
+IMAGE_INSTALL:append:rk-rauc-demo = " ${@ 'data-partition-overlay' if bb.utils.to_boolean(d.getVar('RK_OVERLAY_DEMO'), False) else ''}"
diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
new file mode 100644
index 000000000000..7d9a9e6de82b
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
@@ -0,0 +1,22 @@
+SUMMARY = "Overlay Logic onto the /data partition"
+LICENSE = "OSL-3.0"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/OSL-3.0;md5=438ec6d864bbb958a49df939a56511cf"
+
+inherit rk-rauc-demo-features-check systemd
+
+SYSTEMD_SERVICE:${PN} = "etc.mount home.mount"
+
+S = "${UNPACKDIR}"
+
+SRC_URI = " \
+        file://etc.mount \
+        file://home.mount \
+	"
+
+do_install() {
+	install -d ${D}${sysconfdir}/systemd/system
+	install -m 0644 ${UNPACKDIR}/etc.mount ${D}${sysconfdir}/systemd/system/
+	install -m 0644 ${UNPACKDIR}/home.mount ${D}${sysconfdir}/systemd/system/
+}
+
+RDEPENDS:${PN} += "abd-partition"
diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
new file mode 100644
index 000000000000..65b896563bef
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
@@ -0,0 +1,13 @@
+[Unit]
+Description=OverlayFS mount for /etc to /data/overlay/etc
+Requires=data.mount
+After=data.mount
+
+[Mount]
+What=overlay
+Where=/etc
+Type=overlay
+Options=lowerdir=/etc,upperdir=/data/overlay/etc,workdir=/data/overlay-workdir/etc
+
+[Install]
+WantedBy=multi-user.target
diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
new file mode 100644
index 000000000000..d6a384fa9c75
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
@@ -0,0 +1,13 @@
+[Unit]
+Description=OverlayFS mount for /home to /data/overlay/home
+Requires=etc.mount
+After=etc.mount
+
+[Mount]
+What=overlay
+Where=/home
+Type=overlay
+Options=lowerdir=/home,upperdir=/data/overlay/home,workdir=/data/overlay-workdir/home
+
+[Install]
+WantedBy=multi-user.target
-- 
2.51.0.193.g4975ec3473b4



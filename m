Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6AAD59D84
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:24:33 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.172.1765563871384452729
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 10:24:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=btgwkTUm;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b220ddc189so195206785a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765563870; x=1766168670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUvVkb10UYjVvm816oy49ko4Z3pHzoy/npv6Y8ftfhw=;
        b=btgwkTUm9URb4mMiKzESacjfago8ddAAYHOfNrcUFiV5j/ghLTLReMFaOz5fHrZn+h
         HDAoMu2+exxkEAR56CJTXD819c/IWsbbb9+YT73xu1hnlkx0MgGhzH7/b8p9kDt8Vruu
         UNqkfz8s0M4oIZ45ltaCNYLlG1L220bXehQK4mvSZ6vZKu4wRnjDuNOm3CE+sYI+xswC
         QMhIvZyHJdaZaCvoEK3DJQckA24ADp7/DJ88HtI1j6GkC5Yhk6LtBz0rndIVm+ObcHcX
         6ON+ecsGLDwX21Uv8QYkbEalKjuMitAW1yGUQUNXnu1tMsrY/JsTTE/yJjw1ZyO2nDO6
         OdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765563870; x=1766168670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUvVkb10UYjVvm816oy49ko4Z3pHzoy/npv6Y8ftfhw=;
        b=ifZoRllqacxPQettBWzkSSagLuS0K55VclAuyORgQTRvmsz8djxaO1w/UJj9it/vuc
         HssacExRgdnl+sFBBBJDJSPj2OubLq9ixTNu6aSERa/zwBCBpOsyAPLUm9DKu3avNS+6
         uiOIqNZn2JCsP4pGM67EI1SYmsKWy+q6ubEHx3sQHF716usUqwJg9nYXYXzxsnXxrDIh
         4H29h1oYv8aKmWOkd950pO7edpFCapXFl0VusJOUFKyGkvXYZYmk7tQ0Sifz5YUDYZcv
         S+5uCeFck9Y8nQK1Eu9vrelRyFqSMC75+eYoBK11LBWcYBfUPZMiNKvpfHD7abo3/A+8
         WLRg==
X-Gm-Message-State: AOJu0Yy9vn284XjzneDJeLcDvHyGASJZAoBmFUdJ5J6mObDvrnil07fn
	XplwJ6NTSXeb85STgsAti/fUbpDFPke/qqYoJ1tkoOizIUGA6cA9Pbqu2hBDDQ==
X-Gm-Gg: AY/fxX5ehqr+AmoHd1AEl8sfcsBYRQFnrW47vxRWLyS+nLCDbwynyFqVBa0AifYuPcQ
	83NoXxeErZm8HX6/6EgLbt8y0zRBo11J1zrHjnmp8iYr7AYPNhCMZAOEu36uRMq6r0q4YO3KO1q
	u2FjmtlzWDRewPVqqu24uluuECTUCpLMh3cL4pIE0XLeyk0yigCWu1gF86LBf3SyvE05FQ4UBaV
	4G992M4BtXUARxUvkf+eXsgfTujsN/geh3OISRGPDHOqGdvSxewMdrfir7lGwZFQkL1Zy47tiaO
	2ENlZvBHqrlu8QfZnm4bi80q9E+I3jVR95sBYKFZbc9u3IeQOHs3TPQYxan/Quzbq2lBU1bmsDF
	caxO/0mWyT02z75DNk11H4H2FvEVdr9sgivIm3I8qt+NPw5kiuht++h0PsSgKn3hUHizRhw9rT8
	TrbzEBrrhcvvwZpMkLL0zKTZDE/c9okem2Cclenw==
X-Google-Smtp-Source: AGHT+IH6hSC0lrt3n/TKYvMywo3zkce01hIiuQKX83lvt7NlBFKXUZw4qe/TkEivWaikl6vd99uRpA==
X-Received: by 2002:a05:620a:40d4:b0:8b2:ea5a:4152 with SMTP id af79cd13be357-8bb3a39ca23mr434438185a.87.1765563869532;
        Fri, 12 Dec 2025 10:24:29 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3bd62sm537745985a.35.2025.12.12.10.24.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:24:28 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 1/2] provide a filesystem overlay example
Date: Fri, 12 Dec 2025 13:24:19 -0500
Message-ID: <20251212182420.24920-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 18:24:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2775

Most implementations that use an A/B, full-partition update mechanism
(such as RAUC configured for this scenario) need some way of preserving
system configurations in a location that survives updates. The RAUC demo
provided in this layer is an example of a full-partition update,
therefore provide an example of using a filesystem overlay to preserve
the /etc and /home locations.

This example is gated by a configuration knob:

	RK_OVERLAY_DEMO

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- the commit message was updated to identify the locations that the demo
  will overlay (/etc and /home)
- the README blurb was updated:
  - to also indicate which locations will have an overlay in the demo
  - to indicate the kernel config requirement
  - to explain options on how to include the root's home directory in
    the overlay
- use the standard bitbake variable to place the unit files in the
  standard systemd system unit file location (/usr/lib/systemd)
- use RequiresMountsFor as the overlay mount unit's dependency mechanism
---
 README                                        | 50 +++++++++++++++++++
 conf/machine/include/rockchip-rauc.inc        |  1 +
 .../systemd/data-partition-overlay_1.0.bb     | 22 ++++++++
 .../recipes-core/systemd/files/etc.mount      | 12 +++++
 .../recipes-core/systemd/files/home.mount     | 12 +++++
 5 files changed, 97 insertions(+)
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount

diff --git a/README b/README
index 6a13428d488d..c1d5d4ca1645 100644
--- a/README
+++ b/README
@@ -140,6 +140,56 @@ Notes:
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
+	This demo includes overlays for both the /etc and /home directories.
+	With these overlays in place, you can change a user's password, or add
+	new users, and those changes will be available in subsequent updates.
+	By default bitbake places the root user's home directory in /home/root,
+	but systemd moves this to /root. The location of the root user's home
+	directory is stored in the
+
+		ROOT_HOME
+
+	variable. If you would like to use the overlay example provided in this
+	layer and also overlay the root user's home directory, simply define
+	this variable in your build to place the root user's home directory
+	under /home.
+
+	This feature requires overlay support to be enabled in the Linux
+	kernel. Specifically the following kernel config option must be either
+	=m or =y. By default this layer will use the in-kernel defconfig as a
+	base, which includes this option as a module, and kernel modules are
+	installed by default.
+
+		CONFIG_OVERLAY_FS
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
index 000000000000..9b5a58328345
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
+	install -d ${D}${systemd_system_unitdir}
+	install -m 0644 ${UNPACKDIR}/etc.mount ${D}${systemd_system_unitdir}
+	install -m 0644 ${UNPACKDIR}/home.mount ${D}${systemd_system_unitdir}
+}
+
+RDEPENDS:${PN} += "abd-partition"
diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
new file mode 100644
index 000000000000..c006bd729060
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
@@ -0,0 +1,12 @@
+[Unit]
+Description=OverlayFS mount for /etc to /data/overlay/etc
+RequiresMountsFor=/data
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
index 000000000000..e0f0a89109ca
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
@@ -0,0 +1,12 @@
+[Unit]
+Description=OverlayFS mount for /home to /data/overlay/home
+RequiresMountsFor=/data
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



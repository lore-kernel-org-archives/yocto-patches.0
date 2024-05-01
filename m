Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D85C4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 20:54:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.7733.1714596880965557273
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 May 2024 13:54:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=UNyBTMSc;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso50349825e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 May 2024 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1714596879; x=1715201679; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBceIPzEDsjn3sXT5l7eV51VmaCP0sQQU4rP9I7OdNg=;
        b=UNyBTMScrjP+w0T2ybL7wjLKtfBqHr3f23dnY5yPkLQlX71AhgeAp+8hj489po/KMb
         3yLd0LU4fDWWaFQD+vnJVi9woEjIsoAja+gFmJna6u08QWjx5xee0NmO5afyc0+/OgeR
         PDrtm1XYV7W3gqJlonnTH+r0IQc7FDl7QnlEqFhMtLBTKymebTw/FnshjJKEOu/zzIfE
         soJuiYZi2Zi4ecc1UiWcyF0gDVtflvuynZxyiQz/DCKwo8ysX4WENXg/M+roNUI6AY6p
         QAw7D6NCd0w+P/eBxvL3xO3FVoQRBPeJikbBJS+M9MfvvjBS9IbjuokPNqj1c6xZLhL2
         6apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596879; x=1715201679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBceIPzEDsjn3sXT5l7eV51VmaCP0sQQU4rP9I7OdNg=;
        b=awZl2drczupCJPGvCM/AX/M7HGduFwlZTCSF0UZGPruy81SdhjFzb3TWDb7SA5NEJX
         KIxRmMWzgJ8z9lTdqtCf1Cj+vZmxdqVZaG9HPcbLHZOD5s+b/yA30yJGxuphX8RWS0iG
         utPoX8i6KVdwpAyqOcXKzdNukETUNM2ASlPDHfKaCKc3+tTBhmhGc8ewbblpLw0BB1YS
         VinySYVB2aCaYcAMf+qYfK4JV+gvQYaTSP583ioxAIWmRLhCKaotKar5c95oE1haktmH
         DqXuQWoLcZHzMEzZZHAJ6LdgVzHTAOdFOZBJgHvRz1TQKE0MTwygriqMehO/RpGaGlzT
         UBZA==
X-Gm-Message-State: AOJu0YypMSg1aCGFsNgmE08rWo4mIDjAZNl7UkWzGIlDB8ZzVBJrXShT
	mENoCjA83B462/Fxq0r7Cs9DTsYyF16NRqk+qcJ05ZVolnga3pORipk+W7tqjvf1+bYIHzvTAXb
	w+QA=
X-Google-Smtp-Source: AGHT+IE+Y6HskPysgKLdTiCg08vNFpana6/2mjvaXpOmk0q07BxObI86jePcRdCFn+jSE3uPFJbIOQ==
X-Received: by 2002:a05:600c:198c:b0:41a:b30e:42a3 with SMTP id t12-20020a05600c198c00b0041ab30e42a3mr2539597wmq.37.1714596879054;
        Wed, 01 May 2024 13:54:39 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b00418d68df226sm3319464wmb.0.2024.05.01.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:54:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] config.json: move repro excludes from AB config.json to meta-oe
Date: Wed,  1 May 2024 22:54:11 +0200
Message-Id: <20240501205411.1321591-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 May 2024 20:54:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/79

For now, the known non-reproducible packages list is stored inside the
autobuilder config.json file. This is not ideal. Let's move this list
into each layers of meta-openembedded.

Since commit [0], non-repro-meta-*.inc files contain
KNOWN_NON_REPRO_META_* variables that contain list of known
non-reproducible package, we can use this for
OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES.

[0]: https://git.openembedded.org/meta-openembedded/commit/?id=d3751ce994dcc70be3009cbf982983d051c6f6db

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 51 ++++++++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/config.json b/config.json
index fbf2e6c..fb3b082 100644
--- a/config.json
+++ b/config.json
@@ -338,7 +338,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'e2tools-ptest xfsprogs-doc zfs zfs-dbg zfs-dev'"
+                    "include conf/include/non-repro-meta-filesystems.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_FILESYSTEMS}'"
                 ]
             },
             "step2" : {
@@ -359,7 +360,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'geary geary-dbg gegl-dev gimp gimp-dbg gnome-terminal-src grilo-src gtk-vnc-src ibus'"
+                    "include conf/include/non-repro-meta-gnome.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_GNOME}'"
                 ]
             },
             "step3" : {
@@ -390,8 +392,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-multimedia'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'crossguid libcamera libcamera-dbg libcamera-src libgssdp-1.6-src libgupnp-1.6-src libsquish-staticdev'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'oscam oscam-dbg oscam-src rtmpdump-staticdev'"
+                    "include conf/include/non-repro-meta-multimedia.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_MULTIMEDIA}'"
                 ]
             },
             "step5" : {
@@ -409,14 +411,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-networking'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'blueman blueman-dbg blueman-src civetweb-dev dhcp-relay-staticdev ettercap-src fetchmail fetchmail-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'freediameter freediameter-src freeradius htpdate-doc keepalived keepalived-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'kernel-module-mdio-netlink-6.6.17-yocto-standard libbearssl-staticdev libfko3 libfko-client libfko-daemon'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'libfko-dbg libmosquitto1 libowfat-staticdev libruli-staticdev libsamba-util0 mdio-netlink-dbg mosquitto'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'mosquitto-dbg ncftp ncftp-dbg ncftp-src ndisc6-dbg ndisc6-misc ndisc6-ndisc6 ndisc6-rdisc6 ndisc6-rdnssd'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'ndisc6-rltraceroute6 netsniff-ng-doc ntpsec-src openl2tp openl2tp-dbg ot-br-posix ot-br-posix-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'postfix-cfg proftpd proftpd-dbg proftpd-dev rdist rdist-dbg samba-dbg tayga tayga-dbg wolfssl wolfssl-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'znc znc-doc'"
+                    "include conf/include/non-repro-meta-networking.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_NETWORKING}'"
                 ]
             },
             "step6" : {
@@ -428,20 +424,8 @@
                 "extravars" : [
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'boinc-client-dev cjson-ptest cpuid-doc crash crash-dbg crash-src dhrystone dhrystone-dbg dhrystone-dev'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'dhrystone-src directfb directfb-dbg doxygen-src editorconfig-core-c-dev etcd-cpp-apiv3-dev fbgrab-doc'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'fluentbit-src fvwm-dbg fvwm-doc fvwm-extra gcab-src gosu gosu-dbg gosu-dev gosu-staticdev gphoto2'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'gphoto2-dbg hddtemp-locale-de hdf5 hdf5-dbg hdf5-src hdf5-staticdev hplip hplip-dbg jpnevulator-doc'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'jsonrpc-dev kpatch-build kpatch-doc ldns libbotan-3-bin libbotan-3-dbg libbotan-3-dev libck-doc'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'libdbus-cxx-dev libforms libiio-src libjcat-dbg libjcat-ptest libthrift-c-glib-zlib-src libvncserver-dev'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'libwebsockets-testapps libwmf libyui-ncurses-dbg libyui-ncurses-dev lmbench-staticdev log4cpp lprng'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'lprng-dbg lshw lshw-locale-fr mariadb-dbg mariadb-server mariadb-src mce-test mime-support-doc minifi-cpp'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'minifi-cpp-dbg minifi-cpp-src mozjs-115-src mpv mpv-dbg nana nbench-byte nbench-byte-dbg nbench-byte-src'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'nspr-staticdev openocd openocd-dbg pcp pcp-dev pcp-doc pcp-src perfetto perfetto-dbg php-phar pidgin'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'pidgin-dbg pim435-staticdev postgresql-server-dev qcbor-staticdev sharutils sharutils-dbg smemstat-doc'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'soci-dev thin-provisioning-tools-dev vulkan-cts vulkan-cts-dbg waylandpp-dev yasm-src zlog-staticdev'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'zsh zsh-dbg zsh-src'"
-
+                    "include conf/include/non-repro-meta-oe.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_OE}'"
                 ]
             },
             "step7" : {
@@ -457,7 +441,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-perl'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'libencode-perl-src libhtml-tree-perl libhtml-tree-perl-doc libmodule-build-tiny-perl po4a po4a-doc'"
+                    "include conf/include/non-repro-meta-perl.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_PERL}'"
                 ]
             },
             "step8" : {
@@ -471,10 +456,8 @@
                     "EXCLUDE_FROM_WORLD:layer-openembedded-layer = '1'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'python3-frozenlist python3-frozenlist-dbg python3-kivy-src python3-pycocotools-src python3-pydantic-core'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'python3-pyproj python3-pyproj-dbg python3-pyproj-src python3-pyzmq python3-yarl python3-yarl-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'python3-pandas-dbg python3-pandas-src python3-pandas'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'python3-evdev-src python3-pynacl-dbg python3-pynacl-src python3-pynacl'"
+                    "include conf/include/non-repro-meta-python.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_PYTHON}'"
                 ]
             },
             "step9" : {
@@ -490,7 +473,8 @@
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-webserver'",
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-oe'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-oe'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'netdata-dbg netdata php-phar'"
+                    "include conf/include/non-repro-meta-webserver.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_WEBSERVER}'"
                 ]
             },
             "step10" : {
@@ -517,7 +501,8 @@
                     "USERADD_GID_TABLES:append = ' files/static-group-meta-multimedia'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-multimedia'",
                     "USERADD_UID_TABLES:append = ' files/static-passwd-meta-gnome'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = 'catfish libsamba-util0 samba-dbg'"
+                    "include conf/include/non-repro-meta-xfce.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_XFCE}'"
                 ]
             }
         },
-- 
2.39.2



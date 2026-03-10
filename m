Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3165FD88D2
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 23:35:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8794.1773185704445657790
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 16:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RybxVlIG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so45823755e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773185702; x=1773790502; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp/w3I6DgcvA6MT87FUjdrB+bIl3NYP85CmOf3gA3rM=;
        b=RybxVlIG6Dk/wUKuU3dSPOGeQ5TM9p6dhKk2ZQBxkDdaYu55byzkIwMivfkUelc4Jw
         u8zPo7kwH8Zk9iIn6HjtvU7itOVMu+ca6f2zyQp2FFeA7o1hR9df3W8379+uxWB7Ub8y
         JS+mdZ0H1E/XjXiAmHyi/5PzNEWVgOIn/j1ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185702; x=1773790502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp/w3I6DgcvA6MT87FUjdrB+bIl3NYP85CmOf3gA3rM=;
        b=djTNudPl2V5CQYhJPCZb0bR3w0UmvN7Zg2Qge2D/Co+QV3sKlaR3QjFS7XOAdrV1Qw
         twaF8hTcJ2vaPLwYcy/aotr5B2aCgyOjhq3KvFSHLX1OMi7XSbmDYRUe+09iqI5ca67/
         HI6J5OEayYwa0iI1LObemW1hXAftifIc+FBK85qTa5V+KI9H0/rCY4EkvFvA10sWptv2
         AuHIKxvEOm3YW+4vF7Id36hFc2CAurgMIvZoxoi3Qe8BMYBDi544JPXb59DDG96B5pnM
         fW3vsAXW12PcMXioN4mAqDljXXEdxyQlxCrbn8hYTIZqfSI+X51oFoF6Fk22wUux3tJ/
         4R8g==
X-Gm-Message-State: AOJu0YxDwzveJH0ytsc2z78wqZAJyRPJpkEXESde1dsNIkDxofD4hlwU
	kAbRLx55QjxKju1+8yiAmRGjm1FbfHy6V2fgQP/aRWtiwadVUiUxVruKHzzgTRKltzLYUIrTZE7
	3gLwTKQk=
X-Gm-Gg: ATEYQzzySxZcoZnVrWuSp/FAhXxxgj23zPA1n69s8m+QinSR49YtLQOdl49wEEr+iqR
	pybfBOAkPA8zfSgPr87Dd4OwV5bG3k7kZ2RjeNhLyUlBfLb7KM/EUHfPydJUZZy36Jme4Zu7dqV
	EEM8Q0JFn+KCI6J8D2iXC5iTxVpBu9eSsoh02QplK9pjtwz4tq0z2GA/7kW0VfFWQzyOyE84C5+
	CERVkdBPGHAzk15BA/VSdEGCLcwluP6ssNzhcE/DVYohwkVcjGAEfNgSFjtwgvIffYgENdnEGTn
	X1edwA6fBRIz7kr75ZuLpzg8u5Nb9lUulXe0uT0jqyc2bncvuAUuOCPUA9478x4s+5pLn1L1a80
	sRxmZHXYRU8MkNb1joCl00KJLJ9n/CosZQaeUZVQl0EPNa1Rc2UO3iqgc979Kj0f2ctSkimIea/
	zh2IX6lpY0byitEoxcOSeo46DMt1vYtxFNA4VaC6Z76tcUeMmDGb4=
X-Received: by 2002:a05:600c:4e43:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-4854b0a6a05mr9070425e9.1.1773185701774;
        Tue, 10 Mar 2026 16:35:01 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4968:9824:44c9:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm21643215e9.2.2026.03.10.16.35.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:35:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/2] config.json: Drop vnc usage
Date: Tue, 10 Mar 2026 23:34:59 +0000
Message-ID: <20260310233500.3364868-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 23:35:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3400

We no longer need a DISPLAY set to a vnc server to allow oe-selftest to work, we
can use qemu's inbuilt VNC server instead. We can therefore remove the
vnc starting and DISPLAY settings entirely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/config.json b/config.json
index 1a8284c..cf27ae4 100644
--- a/config.json
+++ b/config.json
@@ -88,7 +88,7 @@
             ],
             "step1" : {
                 "shortname" : "Machine oe-selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
+                "EXTRACMDS" : ["oe-selftest ${HELPERSTMACHTARGS} -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -175,7 +175,7 @@
             "step2" : {
                 "shortname" : "Machine oe-selftest",
                 "BUILDHISTORY" : false,
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t machine -j 15"]
+                "EXTRACMDS" : ["oe-selftest -a -t machine -j 15"]
             }
         },
         "altcfg-hw" : {
@@ -224,7 +224,7 @@
                 "extravars" : [
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -263,7 +263,7 @@
             },
             "step2" : {
                 "shortname" : "OE Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             },
             "step3" : {
@@ -283,7 +283,7 @@
             "MACHINE" : "qemux86-64",
             "step1" : {
                 "shortname" : "Reproducible Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ oe-selftest -r reproducible"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
 
             }
@@ -304,7 +304,7 @@
             ],
             "step1" : {
                 "shortname" : "Repro meta-oe/meta-filesystems",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -324,7 +324,7 @@
             },
             "step2" : {
                 "shortname" : "Repro meta-oe/meta-gnome",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -344,14 +344,14 @@
             },
             "step3" : {
                 "shortname" : "Repro meta-oe/meta-initramfs",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
                 ]
             },
             "step4" : {
                 "shortname" : "Repro meta-oe/meta-multimedia",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -368,7 +368,7 @@
             },
             "step5" : {
                 "shortname" : "Repro meta-oe/meta-networking",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -385,7 +385,7 @@
             },
             "step6" : {
                 "shortname" : "Repro meta-oe/meta-oe",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe"
                 ],
@@ -396,7 +396,7 @@
             },
             "step7" : {
                 "shortname" : "Repro meta-oe/meta-perl",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-perl"
@@ -411,7 +411,7 @@
             },
             "step8" : {
                 "shortname" : "Repro meta-oe/meta-python",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python"
@@ -424,7 +424,7 @@
             },
             "step9" : {
                 "shortname" : "Repro meta-oe/meta-webserver",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-webserver"
@@ -439,7 +439,7 @@
             },
             "step10" : {
                 "shortname" : "Repro meta-oe/meta-xfce",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -484,7 +484,7 @@
             "MACHINE" : "unset",
             "step1" : {
                 "shortname" : "Source Mirror Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
+                "EXTRACMDS" : ["oe-selftest -a -t yocto-mirrors -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "MACHINE = 'qemux86-64'"
@@ -1755,7 +1755,7 @@
             "MACHINE" : "qemux86-64",
             "step1" : {
                 "shortname" : "Yocto Mirror Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
+                "EXTRACMDS" : ["oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -1792,7 +1792,7 @@
             },
             "step2" : {
                     "shortname" : "Source Mirror Selftest",
-                    "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
+                    "EXTRACMDS" : ["oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
             }
         },
         "meta-webosose" : {


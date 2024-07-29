Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92777C3DA70
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.46854.1722215196279075163
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K/SoHS26;
 spf=pass (domain: gmail.com, ip: 209.85.128.170, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-661369ff30aso12989687b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215195; x=1722819995; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t7mSfFBpJJtic5iavgHTLUQCyqjtNIwwCZoT4aQ7gY=;
        b=K/SoHS26pMxi6FC1DsqY5jxN0UbFz3iErOXBf3Wk4yn/U5ctHoNVk8Hu9+ISzV8h+V
         rS5h/iaBIeDIHn1+1Ph7b2ZUjl2X2CeS55MglPspcfrTP4XKj+bBBYnjSkrGbhX8o+2Q
         XW55fo4s9iWJ5sM1bhwaiPidhReV/bdS1AHwxVi/T2B46IlLo68wVX4CJ/HOqyBEXoTl
         6O08r66A6Zux44MRedeRl23xGJrsGxoQJUQ7Qlf8p5MjNhCU1mQg/oMxMnq8uSAqp9gn
         8ONxPcpoDyDbrnmGsRKwCwQDx2lpp0XXhHkgjK7pksBrNf/SjFwHMEEirtkA7cS4f9I5
         eG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215195; x=1722819995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t7mSfFBpJJtic5iavgHTLUQCyqjtNIwwCZoT4aQ7gY=;
        b=jgNKyyjG1AFgNov7GtBAzYPF3cx91DGKbMprrV5zLAY68zm1oVM8yl7tvXY3Uoe3aO
         R2WdPzDqiaiY87YA6eX97sGsoD0PQTGYIlXJa5rZcCXHxv53tiP8OWre0WtM0+sJ57tS
         XMfQZmeWWF/319nJFTmj5TchORlThqiquBEH/1ZxONhdiiI1IC0fHtL6w2C6Y0Rr30f3
         QnBvSAZZB5YxxBogw7/6klGuCBBjZeBx7NuN0mRpVv3OCIDR2Eqcqt0xrlSzx18EZOF5
         MMSYiCyCQlMErYHEt3Buj6K7LgvpFgMszweNySPQZ1CsTKaCtl4R8BdbV/zHJCxQKQDX
         iTCQ==
X-Gm-Message-State: AOJu0YyXmDO0uen/8JuJ4g9v4P0BoZDzDxYMRj3v+bKhBB10EHLRiDcB
	01TO4k0toEFz6HFoDFVW8b3dgnMJvrrYFW1vhT4SdtvujGK8a7Chg2ZS1A==
X-Google-Smtp-Source: AGHT+IE8RrRDKcP/RGKxitXGIKoNfDNN43RMIVFKJVr30JRjOOxNCTGUQGjXyAg0SD+ithaI8oXMQg==
X-Received: by 2002:a81:7c82:0:b0:632:12b:8315 with SMTP id 00721157ae682-67a072bac7cmr62235297b3.22.1722215195180;
        Sun, 28 Jul 2024 18:06:35 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:34 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/6] apparmor: fix QA Warnings
Date: Sun, 28 Jul 2024 21:06:29 -0400
Message-Id: <20240729010634.1991558-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/481

RROR: apparmor-3.1.3-r0 do_package_qa: QA Issue: File /usr/src/debug/apparmor/3.1.3/libraries/libapparmor/swig/perl/libapparmor_wrap.c in package apparmor-src contains reference to TMPDIR [buildpaths]
ERROR: apparmor-3.1.3-r0 do_package_qa: QA Issue: File /usr/lib/python3.12/site-packages/LibAppArmor/.debug/_LibAppArmor.cpython-312-aarch64-linux-gnu.so in package apparmor-dbg contains reference to TMPDIR [buildpaths]
ERROR: apparmor-3.1.3-r0 do_package_qa: QA Issue: File /usr/lib/perl5/vendor_perl/5.38.2/aarch64-linux/auto/LibAppArmor/.packlist in package apparmor contains reference to TMPDIR [buildpaths]
ERROR: apparmor-3.1.3-r0 do_package_qa: Fatal QA errors were found, failing task.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-mac/AppArmor/apparmor_3.1.3.bb | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-mac/AppArmor/apparmor_3.1.3.bb b/recipes-mac/AppArmor/apparmor_3.1.3.bb
index 27c518c..49ab7a7 100644
--- a/recipes-mac/AppArmor/apparmor_3.1.3.bb
+++ b/recipes-mac/AppArmor/apparmor_3.1.3.bb
@@ -74,6 +74,8 @@ do_compile () {
 }
 
 do_install () {
+    sed -i -e 's#${RECIPE_SYSROOT}##g' ${B}/libraries/libapparmor/swig/perl/libapparmor_wrap.c
+
     oe_runmake -C ${B}/libraries/libapparmor DESTDIR="${D}" install
     oe_runmake -C ${B}/binutils DESTDIR="${D}" install
     oe_runmake -C ${B}/utils DESTDIR="${D}" install
@@ -102,6 +104,9 @@ do_install () {
     fi
     chown root:root -R ${D}/${sysconfdir}/apparmor.d
     chown root:root -R ${D}/${datadir}/apparmor
+
+    find ${D}${libdir}/perl5/ -type f -name ".packlist" -delete
+    find ${D}${PYTHON_SITEPACKAGES_DIR}/LibAppArmor/ -type f -name "_LibAppArmor*.so" -delete
 }
 
 #Building ptest on arm fails.
-- 
2.34.1



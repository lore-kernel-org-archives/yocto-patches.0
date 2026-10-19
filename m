Return-Path: <antoine.lubineau@easymile.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE016CCF2E6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 14:59:02 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36908.1792421940607706731
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 07:59:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@easymile.com header.s=easymile header.b=h2cIjHuv;
 spf=pass (domain: easymile.com, ip: 209.85.221.50, mailfrom: antoine.lubineau@easymile.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1834809f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easymile.com; s=easymile; t=1792421939; x=1793026739; darn=lists.yoctoproject.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSHPVB6md2O+KTXd7+W0u6XPaFWDG783XztURO5YiEk=;
        b=h2cIjHuvcDkrBdkgj5eqka7iUSm4RCrm4ijky0o7sXZfuB/fPK9TXy7AzVpkZn0MeS
         hScmdCYaeQqHZJMoZQwB+abGuyJrfhyBxXQwNQrEbBVYSMf5/57O1FdB7bhF+PafHkJv
         22HOGIoJBz4yomlbWlXqFKudWyksWIS9RJ8o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421939; x=1793026739;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bSHPVB6md2O+KTXd7+W0u6XPaFWDG783XztURO5YiEk=;
        b=i6znqm7cZQzFo7UXSgeW3OVjKKp+6DxXuSHJJ5SByEioflyX8JqWauscuC7K4Iy/Ve
         cqnqojxiyHwIyl2Bquhcs/8Sw3U9fM+C5RbDhdHynaS8PtGlSHY+0dgrNWgTOLdtb8oC
         cf5wHGXrP4dDOk4GJYmS/a1QHEn16fI/lI34iW4+a+GSmKFQaWIQpbt+uIV6hTqLCxZy
         u5zlgiaqpUlVOoyND0N6J50/yQ4E/Si8zFPrBtNFYGgOcws6W1BryZhVGA3G0MAvzlYd
         XCdhiByUgwROuJvxqlVD0KNQi6NJZW52zoG306U5q7iwMMVAFqnXnI2yvMpN+oqADgBj
         23aQ==
X-Gm-Message-State: AFq9FYJpc5+wxOD4UyuA4ntgi7wlFXYkulPG/yAMQq/I7FEyup0Mxk37
	4k8Yn/yXDJPrKBRz3nIKxC/QZfizA8Z6qA9O2UxHi17vBWj0ofFkXamQahRZI672tTknZLudu4U
	CXGy81TUwHgoCJqFzcotRURpiZ8D7peSEx6azJSpK+0CchUozz5e8n//0MUX2zSV3fXIAsAsjf8
	yJV68WtVGPifybIRKifKlBRMv6VidiGvl3A3npGtN9RmolGQKVYJVXBEBSdNwZlkxmOEZMZFssV
	EM=
X-Gm-Gg: AYBFou3BXAcMJDUUaynSXesov0605wuHFZj0ESLVNvFvaurC0hmjQAgnD4Ma8KGHuiz
	DU3lLDXYuqMOObJXkJIDWDdZi1qdl/azwrN6jSsdCxC5Nwem7eBEklOEcgo5lv1bdf6fE+y670j
	rQlOHEXwNq5kjzEt3yyXSGt41L3McCjw4yfWbZvwX8reSriJiqGLO+niriZ9YxkW4PfN3scKvzx
	Qa1cRdoF3NM0ksPohOgZ2dYksYCEVbT8g8PWQ/iLnafH+o18OY7+bO/fbiaMHbv/dgp2Sq0YmPi
	Gz2pvR643BoXcLZQW4JsNyfNlZ77nkTAJpRruD92eteVjnBACA8JHBeIeebDhorPTysaT7zBgWs
	0REF03E/jADbW2RPe/VlY5ab9FqSxyGgXWc2bqNLVBccRQehqPTbuyopFNCP2mDYh/46wiUUCGt
	X4vaZgxiJtcqFSctatA6PrFe8TXcCjOGcN2xY+EbQTRM6T0XHI01XigNfAIuJtN23PE8L231sV6
	c7dT5vthc6+wNJfzs/RJWABnyg=
X-Received: by 2002:a05:6000:144e:b0:48e:d88:55e2 with SMTP id ffacd0b85a97d-48e0d885acbmr13301477f8f.42.1792421938538;
        Mon, 19 Oct 2026 07:58:58 -0700 (PDT)
Received: from fr001036.intrad.rvs.em.corp ([90.83.88.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1afbf534sm2211122f8f.35.2026.10.19.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:58:58 -0700 (PDT)
From: Antoine Lubineau <antoine.lubineau@easymile.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <raj.khem@gmail.com>,
	Khem Raj <khem.raj@oss.qualcomm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [meta-lts-mixins][wrynose/go][PATCH 1/2] go: skip internal/cgrouptest when cpu.max is not available
Date: Mon, 19 Oct 2026 16:58:52 +0200
Message-ID: <20261019145853.154403-1-antoine.lubineau@easymile.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:59:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5098

From: Khem Raj <raj.khem@gmail.com>

The internal/cgrouptest ptest fails on qemux86-64:

  Erroring setting cpu.max: open /sys/fs/cgroup/go-cgrouptestNNN/cpu.max: p=
ermission denied

cpu.max is only present in cgroup v2 when the kernel is built with
CONFIG_CFS_BANDWIDTH, which the linux-yocto qemu configuration does not
enable, even though the cpu controller is available. Writing the missing
file makes cgroupfs return EACCES.

Add a patch so that InCgroupV2 skips the test when the new cgroup has no
cpu.max, consistent with its other best-effort checks.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Antoine Lubineau <antoine.lubineau@easymile.com>
---
 recipes-devtools/go/go-1.27.1.inc             |  1 +
 ...est-skip-when-cpu.max-is-not-availab.patch | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 recipes-devtools/go/go/0011-internal-cgrouptest-skip-wh=
en-cpu.max-is-not-availab.patch

diff --git a/recipes-devtools/go/go-1.27.1.inc b/recipes-devtools/go/go-1.2=
7.1.inc
index 61df455..d7ba03b 100644
--- a/recipes-devtools/go/go-1.27.1.inc
+++ b/recipes-devtools/go/go-1.27.1.inc
@@ -15,5 +15,6 @@ SRC_URI +=3D "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch=
 \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch=
 \
+    file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch=
 \
 "
 SRC_URI[main.sha256sum] =3D "4e408abae126d916b6164627193f2c54f0e3ca1312d69=
3b86db45f862ab238b1"
diff --git a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.=
max-is-not-availab.patch b/recipes-devtools/go/go/0011-internal-cgrouptest-=
skip-when-cpu.max-is-not-availab.patch
new file mode 100644
index 0000000..f13cf78
--- /dev/null
+++ b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-=
not-availab.patch
@@ -0,0 +1,39 @@
+From 3335a08288a68ebce5f3e99745186ded36c564c9 Mon Sep 17 00:00:00 2001
+From: Khem Raj <khem.raj@oss.qualcomm.com>
+Date: Thu, 24 Sep 2026 10:22:23 -0700
+Subject: [PATCH] internal/cgrouptest: skip when cpu.max is not available
+
+The cpu.max interface file is only present in cgroup v2 when the kernel
+is built with CONFIG_CFS_BANDWIDTH, even if the cpu controller is enabled
+in the parent's cgroup.subtree_control. Without it, SetCPUMax tries to
+create the file, which cgroupfs rejects with EACCES, and TestInCgroupV2
+fails with:
+
+  Erroring setting cpu.max: open /sys/fs/cgroup/go-cgrouptestNNN/cpu.max: =
permission denied
+
+Skip, like the other best-effort checks in InCgroupV2, when the new
+cgroup does not have cpu.max.
+
+Upstream-Status: Submitted [https://github.com/golang/go/pull/81745]
+Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
+---
+ src/internal/cgrouptest/cgrouptest_linux.go | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/src/internal/cgrouptest/cgrouptest_linux.go b/src/internal/cg=
rouptest/cgrouptest_linux.go
+index ad9599c..a4b9b52 100644
+--- a/src/internal/cgrouptest/cgrouptest_linux.go
++++ b/src/internal/cgrouptest/cgrouptest_linux.go
+@@ -82,6 +82,12 @@ func InCgroupV2(t *testing.T, fn func(*CgroupV2)) {
+ 		}
+ 	}()
+
++	// cpu.max only exists when the kernel supports CPU bandwidth control
++	// (CONFIG_CFS_BANDWIDTH), even if the cpu controller is enabled.
++	if _, err :=3D os.Stat(filepath.Join(path, "cpu.max")); err !=3D nil {
++		t.Skipf("cgroup %s does not support cpu.max: %v", path, err)
++	}
++
+ 	migrateTo(t, path)
+ 	defer migrateTo(t, orig)
+
--=20
2.55.0


--=20


*This email and any attachment contains EasyMile's confidential=20
information, and must not be modified or circulated without EasyMile's=20
prior written consent. It is intended exclusively for their recipient.s. If=
=20
you received this message by mistake, please notify us promptly and=20
immediately delete this email and any of its attachments.*

*As data=20
controller, EasyMile processes personal data, in compliance with the=20
European GDPR (EU) 2016/679 of 27 April 2016. To exercise your rights, you=
=20
can contact EasyMile at privacy@easymile.com, and if necessary, you may=20
contact the local competent supervisory authority."*

*Cet e-mail et toute=20
pi=E8ce jointe contiennent des informations confidentielles d'EasyMile et n=
e=20
doivent pas =EAtre modifi=E9s ou diffus=E9s sans le consentement =E9crit pr=
=E9alable=20
d'EasyMile. Ils sont destin=E9s exclusivement =E0 leur destinataire.s. Si v=
ous=20
avez re=E7u ce message par erreur, veuillez nous en informer rapidement et=
=20
supprimer imm=E9diatement cet e-mail et toutes ses pi=E8ces jointes.  *

*En=20
tant que responsable de traitement, EasyMile traite des donn=E9es=20
personnelles, conform=E9ment au RGPD europ=E9en (UE) 2016/679 du 27 avril 2=
016.=20
Pour exercer vos droits, vous pouvez contacter EasyMile =E0=20
privacy@easymile.com <mailto:privacy@easymile.com>, et si n=E9cessaire, vou=
s=20
pouvez contacter l'autorit=E9 de contr=F4le locale comp=E9tente.*


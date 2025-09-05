Return-Path: <raitosyo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88366CA1013
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 11:28:46 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.19047.1757071717891135725
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 04:28:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MQtZrKMc;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: raitosyo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso1401699a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757071717; x=1757676517; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylf3ViwmZ4vYi3vyVntF7DL6XB8AxM+/I99dfuUQ4Ic=;
        b=MQtZrKMcZj+0RmqQy0YnehaIlx8os9N8ieA+XzAEenan+cOmVCvagq/8WyBPqdjwlw
         qf/XEUzKO+5kihz2nqj2/iZsEpVK311z4SG6/tt6koSUL3wF6iSnq7ejGwvGrau+Dny2
         ZPVP1VTvtz0Et9zF5wbt94etQzRnmDDMlWqD5M5aggOx3zpHXnwoHDVsmkrr//wW8NS1
         ngBdAiqptxKg9WLXh8l0mKA+87v5BBmZPVUO218UFJ3F6okJ07hysNPasttk96kThYke
         WWmOGt/gFbLjNSAzjC1PtdQ8JfDubCOTQ5r9tzWO6uE1s095IxMrTgt5CR4dYvLmGoEX
         s2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071717; x=1757676517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylf3ViwmZ4vYi3vyVntF7DL6XB8AxM+/I99dfuUQ4Ic=;
        b=xLW6B8W3w0B5fqTHNrRJ4MCqfF+eFo/fe3t5sZUSzMNiW21J3GU/6Fvd1X18OMnS/Z
         3K3UKlGWnsviyrhMyI+OIVW63FtW/OikZNq+lTzuFOwVHnO9lAm1jgqic0/rBF8RQ7dM
         wrSC9H05k4En19aSE8NHww0DV7paRcAoG6GE23Y4MfYoqL3K5PtqzNhhqO70eoP2gJV6
         deyZLvQ36M1UeyjCAYsFjVggVrKumT/6kpKUEdXc4e0WBlIvFqkHSQXUDtcT4Q0479VE
         MTgpq2btQEdE+iuGj3E1dFK8tlt1sMN4/hfQrj6Y3x4iBuR0nP46z2hnHiXnp3JMUtEg
         H09w==
X-Gm-Message-State: AOJu0YyoWuzTYabwgUNRtEiH5MW18Suaa0HhOBqMzOnMiUy4wtZxQ2+K
	amjQlfhiBdHXINBQKYgqOQRL8/WxLJT0LFToT6zU2tWeS+rDUAhw74Va8k0q4A==
X-Gm-Gg: ASbGncu1Djl81NbV22nLHQeAR33HlRcHqotMxKWOtAzWnqwFnHEqtgGgDPogaZ/E6B/
	VbyrPbQ4hCe/b5ukYCrMFi4X7h2+wryLEX43iKBR8+DWfvDO9Ep7Ch1z5/iMJJPzqiQBwUhYVxc
	hKu23YotXnazm6thuCeXZ8E7NJzl9+3M+NUE6KKxhsrKEXdHDybMHlsiT5Su/BjQDKb6eb6AhMD
	aeIJe1rINozZTGF6EYkSl+jI4+b0gi531nhOJI/54EWIukqgvw2JmCAC7R1LPiOsoqZoYs0F8B7
	Qx+DO1o4g6bQZ/0t23Vg5nISmgsSjvx+vfCOUSRoV6f0Cnp900j9u1+FcR65RRgsCibwHDp0i5J
	UU9S5+x+7WKSe/oE=
X-Google-Smtp-Source: AGHT+IHPthXizZyHSR2B6S+F8XbRwV7aTjpPT0P4i8UkUk++cvlMKsbgHQpLZp36xJL74tZ+Shi7EA==
X-Received: by 2002:a17:90b:2ec7:b0:327:f20b:90b5 with SMTP id 98e67ed59e1d1-32815412230mr29789995a91.4.1757071716791;
        Fri, 05 Sep 2025 04:28:36 -0700 (PDT)
Received: from fedora ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd33c1sm27664978a91.17.2025.09.05.04.28.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:28:36 -0700 (PDT)
From: Ryosuke Saito <raitosyo@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-cgl][PATCH] meta-cgl-common: Clean up S overrides
Date: Fri,  5 Sep 2025 20:28:28 +0900
Message-ID: <20250905112828.592873-1-raitosyo@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 11:28:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2140

From: Ryosuke Saito <ryosuke.saito@linaro.org>

Fix S assignment to fix the build error:

do_unpack: Recipes that set S = "${WORKDIR}/git" or S = "${UNPACKDIR}/git" should remove that assignment, as S set by bitbake.conf in oe-core now works.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb | 1 -
 .../cluster-resource-agents/resource-agents_4.5.0.bb            | 2 --
 meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb                | 1 -
 meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb    | 2 --
 meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb        | 2 --
 meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb        | 1 -
 meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb     | 2 +-
 meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb       | 2 +-
 meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb      | 2 +-
 meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb           | 2 +-
 10 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
index aed8be6ef132..0184e7dbcc1c 100644
--- a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
+++ b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
@@ -32,7 +32,6 @@ SYSTEMD_AUTO_ENABLE = "disable"
 HA_USER = "hacluster"
 HA_GROUP = "haclient"
 
-S = "${WORKDIR}/git"
 PV = "1.0.12+git${SRCPV}"
 
 PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
diff --git a/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb b/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
index a1b662499c94..3c722750a85d 100644
--- a/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
+++ b/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
@@ -28,8 +28,6 @@ SRCREV = "fee181320547365d7f8c88cca2b32801412b933d"
 
 UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
-S="${WORKDIR}/git"
-
 LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
                     file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c \
                     file://COPYING.GPLv3;md5=d32239bcb673463ab874e80d47fae504"
diff --git a/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb b/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
index 8f319b5073f6..065f9f05fd5b 100644
--- a/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
+++ b/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
@@ -12,7 +12,6 @@ DEPENDS = "asciidoc-native \
            "
 RDEPENDS:${PN} = "pacemaker python3-lxml python3-parallax gawk bash python3-doctest"
 
-S = "${WORKDIR}/git"
 SRC_URI = "git://github.com/ClusterLabs/${BPN}.git;branch=master;protocol=https \
            file://tweaks_for_build.patch \
            file://0001-orderedset.py-fix-deprecation-on-collections.Mutable.patch \
diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
index 8cce2598be76..fd7e8ef915f9 100644
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
@@ -25,8 +25,6 @@ SRCREV = "4d76ceb4aa7aaa1fd595368089e99575d708f719"
 
 UPSTREAM_CHECK_GITTAGREGEX = "ocfs2-tools-(?P<pver>\d+(\.\d+)+)"
 
-S = "${WORKDIR}/git"
-
 inherit autotools-brokensep pkgconfig systemd
 
 DEPENDS = "corosync pacemaker \
diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index 4f0f56316e46..04bb62fcf939 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -28,8 +28,6 @@ SRCREV = "ba59be71228fed04f78ab374dfac748d314d0e89"
 
 inherit autotools-brokensep pkgconfig systemd python3native python3-dir useradd
 
-S = "${WORKDIR}/git"
-
 UPSTREAM_CHECK_GITTAGREGEX = "Pacemaker-(?P<pver>\d+(\.\d+)+)"
 
 CLEANBROKEN = "1"
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index d0daa914a817..0a04bf5aa960 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -33,7 +33,6 @@ SRC_URI = "git://github.com/zoulasc/racoon2;branch=master;protocol=https \
           "
 
 SRCREV="7b68950328454b0e91ba24698c10c4a790705cc1"
-S= "${WORKDIR}/git" 
 SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
 SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"
 
diff --git a/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb b/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
index 4c67582df219..c1707fdca77e 100644
--- a/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
+++ b/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
@@ -20,6 +20,6 @@ PR = "r2"
 SRC_URI = "http://search.cpan.org/CPAN/authors/id/M/MA/MARKOV/MailTools-${PV}.tar.gz"
 SRC_URI[sha256sum] = "4ad9bd6826b6f03a2727332466b1b7d29890c8d99a32b4b3b0a8d926ee1a44cb"
 
-S = "${WORKDIR}/MailTools-${PV}"
+S = "${UNPACKDIR}/MailTools-${PV}"
 
 inherit cpan
diff --git a/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb b/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
index a01620cea796..b2d4838d3415 100644
--- a/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
+++ b/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
@@ -15,7 +15,7 @@ SRC_URI = "https://cpan.metacpan.org/authors/id/U/UM/UMEMOTO/Socket6-${PV}.tar.g
 "
 SRC_URI[socket6-perl-0.29.sha256sum] = "468915fa3a04dcf6574fc957eff495915e24569434970c91ee8e4e1459fc9114"
 
-S = "${WORKDIR}/Socket6-${PV}"
+S = "${UNPACKDIR}/Socket6-${PV}"
 
 do_configure:prepend () {
 	mkdir -p m4
diff --git a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
index 968c628458f2..f72dbd390061 100644
--- a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
+++ b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
@@ -14,6 +14,6 @@ PR = "r2"
 SRC_URI ="http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/Test-Pod-${PV}.tar.gz;name=test-pod-perl-${PV}"
 SRC_URI[test-pod-perl-1.52.md5sum] = "472dda77746d48e6465bf62e47aeca81"
 SRC_URI[test-pod-perl-1.52.sha256sum] = "60a8dbcc60168bf1daa5cc2350236df9343e9878f4ab9830970a5dde6fe8e5fc"
-S = "${WORKDIR}/Test-Pod-${PV}"
+S = "${UNPACKDIR}/Test-Pod-${PV}"
 
 inherit cpan
diff --git a/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb b/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
index 5a4f55cadc0f..ea7f44fe7dfb 100644
--- a/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
+++ b/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
@@ -18,6 +18,6 @@ PR = "r2"
 SRC_URI = "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/libwww-perl-${PV}.tar.gz;name=libwww-perl-${PV}"
 SRC_URI[libwww-perl-6.43.sha256sum] = "e9849d7ee6fd0e89cc999e63d7612c951afd6aeea6bc721b767870d9df4ac40d"
 
-S = "${WORKDIR}/libwww-perl-${PV}"
+S = "${UNPACKDIR}/libwww-perl-${PV}"
 
 inherit cpan
-- 
2.51.0



Return-Path: <mark.yang@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E58DC43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 08:00:54 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64599.1782979253208258912
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 01:00:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.51, mailfrom: mark.yang@lge.com)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.51 with ESMTP; 2 Jul 2026 17:00:51 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: mark.yang@lge.com
Received: from unknown (HELO jenkins-X670-AORUS-ELITE-AX..) (10.177.121.125)
	by 156.147.1.125 with ESMTP; 2 Jul 2026 17:00:51 +0900
X-Original-SENDERIP: 10.177.121.125
X-Original-MAILFROM: mark.yang@lge.com
From: mark.yang@lge.com
To: yocto-patches@lists.yoctoproject.org
Cc: "mark.yang" <mark.yang@lge.com>
Subject: [meta-tensorflow][PATCH] tensorflow.inc: add CVE_PRODUCT
Date: Thu,  2 Jul 2026 17:00:50 +0900
Message-Id: <20260702080050.370258-1-mark.yang@lge.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 08:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4363

From: "mark.yang" <mark.yang@lge.com>

CVE records are filed under product "tensorflow"
NVD: google:tensorflow with TensorFlow Lite issues carried as the "lite"
software edition), so the tensorflow-lite recipes match nothing with
their default product names.

Signed-off-by: mark.yang <mark.yang@lge.com>
---
 recipes-framework/tensorflow/tensorflow.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index e337519..f779755 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -2,6 +2,8 @@ DESCRIPTION = "TensorFlow C/C++ Libraries"
 LICENSE = "Apache-2.0"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=4158a261ca7f2525513e31ba9c50ae98"
 
+CVE_PRODUCT = "tensorflow"
+
 DEPENDS = " \
     bazel-native \
     protobuf-native \


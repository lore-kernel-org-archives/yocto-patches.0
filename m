Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08322CC6B38
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 22:02:40 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9252.1792101754643253262
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 15:02:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b48n9/AD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1af482519so3082645e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792101753; x=1792706553; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0CpU1775Nr/6ElaoXmbuouh9J9vgf2tArPiEEadu9IQ=;
        b=b48n9/ADvd0pdL8hQGDxPJkdaEzDIQUiXlYiahzBdnVBwpkgRw5zi5ETO+OEPTTpKe
         p/7woW5NGNW+K8DRKz5qTrm6/AFwRjHWLscgIGb5UxQ3Kio3PhXTg6H0RuLNkhJOy1SS
         78AQeh0VwCvd9cG1Ec+S2DoEuvWG+4sXkmsQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101753; x=1792706553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0CpU1775Nr/6ElaoXmbuouh9J9vgf2tArPiEEadu9IQ=;
        b=pGWmcJNOrebfRlEhZiXSlpUpbztWkiqilv7VN+8AktbEdBcwU1T0CHKgY94EEyWrwv
         5ldU3Ee+8Z/MzEPzLX4lVfN7ZXEM3bKV3hpGZwP4SYx3CPSICJbZx7gnsOPw4cWOV+JJ
         If2+CFSikjb5rhfooBF1pE0k8lwXNkTU5QU73wEiqu1kQi/8O2CBi381jxJs2Pv4C1Pu
         cejWDUBNuZCPr2zsKHb7MlpW4ozT+pGFjSKxDgOrMs9GSzWrvAL8qGDbvSfK2L5R26+o
         YtaZlCXsIdL5H6l0SZT2NMLUrtNOPz8qU9fHBE5qicVyKDbuHUb3asROug4jg3L/U2Zw
         dqUQ==
X-Gm-Message-State: AFq9FYJdNHXin++5MZrPfdTM+qZZOCE4+NaJNyqH+KFZcY5iB4+V3iMo
	sVc/NmpYZGvmNcAH13AEBemHyIOCLHLmv85Oh1FhOIHlMdLPhWrOpa4jQmITU19n9CuT9FlVwm2
	tegJKT9M=
X-Gm-Gg: AYBFou39+uoR7QQPwLdE4rWJC3ORJE3xO/gH6Q9pmy/PuDOIVkmU8LM/PYtccltSoEq
	2UedR93j747BDXGcDk3FuQPmBFpx/UAeSp8G9pdmf3UQDWZ3mRznT+gavELSD1YV0KiuH/fG/ar
	PJUS3W25ksgz68763IBOTXWqFDrK7FmBjEaGBO5yGeT3Sq0fjpiIRfUqvsgF5cvfbIMmj2v5Hpm
	/wJ5cVycWpaBfTZebyAOMgSdOtg6rHMQCkE42C4JyFM6YIDJ//wRdyxI3rrXtFc14Hem2vJftCt
	nKEjD/svwBDhQz4+2KoGQF8wJxzEyg09sPYHro8l9G4jEkTBnfkYMARfPrTrXZcmngtqUH8hCoz
	QlJJ1PYzTS92vAEgTr7MXCfNahrrT1CLIB22rlbUbub/qVRN5SZ+8bVAB6/1xSH6U/WtHTCvJQX
	9uPwjTNPFSD035PW3k8zhn7lPivccsphZrmDT8nLBD7ML2MCnIgY05H0bT9f+RsJiqcVp05XCK8
	8ayyU04+jPll73uAzynG4znJYY=
X-Received: by 2002:a05:600c:4504:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a1c6674ecamr31818065e9.11.1792101752125;
        Thu, 15 Oct 2026 15:02:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dcbd:69cc:7c20:c55f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca30aa4sm693085e9.2.2026.10.15.15.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:02:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH v2] pseudo_client: Fix xattr/rename handling with empty paths
Date: Thu, 15 Oct 2026 23:02:27 +0100
Message-ID: <20261015220227.794655-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 22:02:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5033

On Fedora45, we can end up in a situation where path_extra_1 (for xattr/rename ops)
but path is of zero length. The path_extra_1 codepath does not handle this well and
corrupts memory.

The issue is "partial_len = pathlen - 1 - strip_slash" when pathlen is 0 (and
hence strip_slash is also 0). This leads to invalid memory writes and if those
happen to access off the end of a mapped segment, the program segfaults.

Fix the code to handle the pathlen=0 case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_client.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index d83175e..1c742ba 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1791,7 +1791,11 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	 */
 	if (path_extra_1) {
 		size_t full_len = path_extra_1len + 1 + pathlen - strip_slash;
-		size_t partial_len = pathlen - 1 - strip_slash;
+		size_t partial_len = pathlen - strip_slash;
+		if (!pathlen) {
+			full_len += 1;
+			partial_len = 1;
+		}
 		if (path_extra_2) {
 			full_len += path_extra_2len + 1;
 		}
@@ -1806,12 +1810,14 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				return 0;
 			}
 		}
-		memcpy(alloced_path, path, partial_len);
-		alloced_path[partial_len] = '\0';
-		memcpy(alloced_path + partial_len + 1, path_extra_1, path_extra_1len);
-		alloced_path[partial_len + path_extra_1len + 1] = '\0';
+		if (pathlen) {
+			memcpy(alloced_path, path, partial_len - 1);
+		{
+		alloced_path[partial_len - 1] = '\0';
+		memcpy(alloced_path + partial_len, path_extra_1, path_extra_1len);
+		alloced_path[partial_len + path_extra_1len] = '\0';
 		if (path_extra_2) {
-			memcpy(alloced_path + partial_len + path_extra_1len + 2, path_extra_2, path_extra_2len);
+			memcpy(alloced_path + partial_len + path_extra_1len + 1, path_extra_2, path_extra_2len);
 		}
 		alloced_path[full_len - 1] = '\0';
 		path = alloced_path;


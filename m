Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A829FC9EE7
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6729.1772879415713983701
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Tz3r/xwf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so32353276d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879414; x=1773484214; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GFirBgdGIBdelKg5t6JXlYw2LzFry/SQMuuwP9JCqM=;
        b=Tz3r/xwfuivc+Nc6bcffoG6VRrlkdWD7DqH/isHAb0sWepgcqIyYNdOL4U2vzXYg8Z
         u0l5k7lKHG4phM2RE30+piIiicomsk7TLIcsGtAmWjUVzPFGgElD36EhiOWkqFoK93KE
         3lomgDG6nyE+ByBGGqtxPTLV1e/ZN72jY/zD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879414; x=1773484214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GFirBgdGIBdelKg5t6JXlYw2LzFry/SQMuuwP9JCqM=;
        b=DT8jytL5Aticidu5VSi5CDmRJzyyhT9Ru1E3dx/nB+UWz6aUCjIhJ2pELFDGtRNZTk
         k0oS7/PLng3x4B6oc/S0cPrEddf+FLfI0LzXqvttbztwHueDucvP9htO/+n0OeA96nxQ
         0Qv9OTB+jwTfkaNwn9VAbpWUGDGvhbGa5vSq6r5Nqel1CSLdu/Lw3U6vmBXsTa1b2fNi
         gtORe/6t5g0+i3K4YuA7BKwd/P8sJVvJf15H2D2KTcG0z+Bk7+Ucs2kGoJg6V3+JDAB8
         wOPsaGm3W5Z0gMBT7VJ+U7t958xZhkREBjVoilivcXyHzg702hndv5GaFa3bGhAk7hyN
         aFbw==
X-Gm-Message-State: AOJu0YwsttGwzROiqt55eYyxJgTNh2dcrQkSgDJn0dZA9MmRRsJ1h+yk
	9nBPhJOwFasuK5EVMfsnLh6LGIyPM6JOMwFm1RfAKrs2zZIR8gpkoqpfhZelPtzw5yiy8NUmMqz
	sFM/hnCI=
X-Gm-Gg: ATEYQzy79nMGHOSU0gbmJp+vAZuQI0evC69gqNnU5iY6J04WTYcCkn4qimEBHzQMPFJ
	0SvYrCkwALQhesWE9ct0jI6XLBA8NaobwqB5KTA1K9utxnaPgGvvyZsNzxLoL88wzHTmO/mYX16
	l15N7GrwtEUBmgaiEiXDmrHtOhtDuz+ba7qH7T3OyuJjVNAmWxPjee4+V8Ktrgv9/PplzJsKl3F
	XWoa0PdT0ZoYaOJCOtwDO8gvx8tjsuPQDfWEGEObG9Jcn0SSPxbMXW0eZ1yudAelILovwHYtCWb
	X95ZMnvApzS95DMEttb4vv9ygD1X347+3D8Cgv/h/zxM3+xqr98IwXgRdyv/Gf43fiXWsUZF2No
	lRWGyWBEo9AO75LxsTnMCLtxSw90lvRKNOkIhSMy9VMpX8/RLE/0MkqTKJsbZPQ6IyZqheD6TX6
	Hm9yyFTJybqxuPV4SA1iW1WcYBn5RnwO9jufAODlzgPOVfoD9ZIsuzybUK+USgCNBFt/S1DEo4g
	TTpjoHUhe3pdXZalIDna1XK4xnRpex1Xten2brhDsVCIl1Ul0Vo/mLlK1iGcYLW
X-Received: by 2002:a05:6214:2b08:b0:89a:ec6:1028 with SMTP id 6a1803df08f44-89a30a65275mr70724376d6.30.1772879414128;
        Sat, 07 Mar 2026 02:30:14 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:13 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/7] python3-tpm2-pytss: BBCLASSEXTEND native and nativesdk
Date: Sat,  7 Mar 2026 05:29:56 -0500
Message-ID: <f04f6fede966257d765ccdd22d671f93142afe57.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3367

From: Peter Marko <peter.marko@siemens.com>

Commit cd729862f68152bc76db02cd4a93ca12a9424f88 added native/nativesdk
possibility to tpm2-pkcs11.
After 784ca4b6584101e971b2d5d76ec7b716ad1301b5 which added rdepends on
python3-tpm2-pytss, there are errors like:

Missing or unbuildable dependency chain was:
['<image>', 'swtpm-native', 'tpm2-pkcs11-tools-native', 'python3-tpm2-pytss-native']

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 4ddf287..63ed8cf 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -19,3 +19,5 @@ DEPENDS = " \
 "
 
 RDEPENDS:${PN} = "libtss2 python3-asn1crypto"
+
+BBCLASSEXTEND = "native nativesdk"
-- 
2.51.0



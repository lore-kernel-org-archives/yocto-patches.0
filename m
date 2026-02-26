Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13004FC5937
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 11:44:50 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68117.1772106285602691437
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 03:44:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=THfCI7jT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4376acce52eso501972f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 03:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772106283; x=1772711083; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3BuZ4CFyTv3J+5rVtfDHz7YMLjKClqE3yO1WBJVtZk=;
        b=THfCI7jTA28euJH0fMkFoOmjPJBTyjD3/TYcFKXR7a66dlYGgtDXQzoTsUF/C7TpJ8
         eLOp2FiQxbjnLsaDcPlREU0H7P98rqxtG+LXxKnpHJKsDEwW1SY08I7odmEn6QCLWfOo
         rdqbmL3G2IpX51gTZulQXMCEeIrOZi8smIu5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106283; x=1772711083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3BuZ4CFyTv3J+5rVtfDHz7YMLjKClqE3yO1WBJVtZk=;
        b=jGBq1OwlNb2035+M9DHHsl/vcnrc3I7zPbbPA2ZPT7STbCjlgSnx0lRWW72XyflTwl
         dwaZAcHhajCtHBmG8Rt+RzdAbXVJC/zBnLkoNflMhQQSsiSlmoiD3GatLAzXUUp5ga6v
         orAlbYSUic/w9FeXlH9tBi/wIlMXFCx2UDHeIBMfu+fLyFmlf846GDwTs7QZQOaN+Qmz
         OsgQr6mtdNN1rSxjWDRXqIQ2rrX63yf9BwjzmKkbsQclKgyyX9EpXgHrCRxWB3dSG94F
         sNcKcgtRWAD/2qcfOfF5ioWsdSgAUwlPQvIzanX22vSd/13g4pPfboozXvGc6e3FjhpF
         Kvqw==
X-Gm-Message-State: AOJu0YwMTe1xOMFVC+hActUEmviTFL/E50dxG5i73PuTk9jhKZzZJ/6G
	kQECPCGQjeRFwud9p3C+aZMu+9EPxHOA3yZ9LI2Oz+Qvv7EyM77giU6wK2WfUsLj8vFNQ84IUUZ
	IiyNAIu4=
X-Gm-Gg: ATEYQzyjd8WYAMkF9pF3noNJUZYUR0VwmSDLsH/NP2mXbadSfvgY5Fwsk4F/NnVceOv
	Owzbs1mN3KAi7E6qA0cKYMPYYVoeHyu/2mU4mSLIuE0cy33Dt7hSulF4BinNyDxqpYXY2/aG7jM
	i5eknxFVHJNNHgjaocvEFUwDfLBgMQcFY0ahAGUxh9TEzkkaCoEVuVGA29kOS2hNb6/pKib5yIc
	OKDlD0qcrULFaUYjfl1tCGE3iASonk+SvokK1XvWrtGCp9gsfwl8uxlozmfgPp3P+FTP91O7tHt
	UABxxsZPNZZ2RmVPWIPv89U9OioehddwWO3wa4EIFqhnSuEX5vlXzl0HRvZbRdCqghOVlNIFQHs
	UX8vXDqPh0P//O9psMvFrQmhvo1XYCCSpKmKEe7bzvKeHrB/bNGnwmrqZnwbUq0621xHps4Hr2g
	YjpFMLP4S1gLBYyCXWHrB2AXWgMESNKJFIsiHEyHLOMe6mQ0yTFOQ=
X-Received: by 2002:a05:6000:290f:b0:436:2f66:5d1a with SMTP id ffacd0b85a97d-43997eda5d9mr3835726f8f.8.1772106283318;
        Thu, 26 Feb 2026 03:44:43 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398a09aad0sm16165745f8f.2.2026.02.26.03.44.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:44:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Update oecore build to match default changes to nodistro
Date: Thu, 26 Feb 2026 11:44:42 +0000
Message-ID: <20260226114442.705162-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 11:44:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3280

This config is now the default for OE-Core, remove the unneeded options.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 --
 1 file changed, 2 deletions(-)

diff --git a/config.json b/config.json
index 05db992..9c5d294 100644
--- a/config.json
+++ b/config.json
@@ -500,8 +500,6 @@
             "DISTRO" : "",
             "BBSETUP_CONFIG" : ["oe-nodistro-master", "nodistro"],
             "extravars" : [
-                "INHERIT += 'uninative'",
-                "require conf/distro/include/yocto-uninative.inc",
                 "BB_SIGNATURE_HANDLER = 'OEEquivHash'"
             ],
             "step1" : {


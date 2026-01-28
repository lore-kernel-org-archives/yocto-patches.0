Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D8D46BE6
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 17:42:03 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.548.1769622116767541231
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 09:41:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B9t777yT;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c838069e5so99009b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769622116; x=1770226916; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EfxL1jgKPUwv92IMrYI8OOxunNj4JpfQDsEmoucOEQ=;
        b=B9t777yTnlsU/K0CxL2jMf1JU+YfGPMySAdijwvxmoOFGKMkAJ78DpbtpwsJhz4UAZ
         oc0PGOrPMGPddKoejzo6p2cscs85eozvRCCvip9OlDElFCxHbQyqTsldDv0iEiBHiFae
         XQbqzqdvY9lCAaRY7U75MaspsUVbhuwGvKwY2kR/ksJHU1yfrI8P4x+Imx3RhqJQjywL
         L33hOLF8TaicuzzxVtQNEtGYJ+3JKXWsXNP4v7vEDyCxA09HQzJ+9iyMXPZWMDjFWl4T
         kNDD/a10duiEVJGgiedquotNr6ADXSguh6ql9fqNweHsHCVxe8DOo792BnWDASYpTPCH
         DLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769622116; x=1770226916;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EfxL1jgKPUwv92IMrYI8OOxunNj4JpfQDsEmoucOEQ=;
        b=w1fgtqEi13SyzbG+aXKb0ORsyUnsWBTqm0/JOFyALeiJaF8S+KmQqwj4HLAr/+2fHS
         sD8nLPrMnDKxuex+0yTUwgJ2SC4uZuwhbdEl45fetLxXjLjbYMTTb25jTo4g1dDKPFM8
         WJawKUjEK3KQdprB7dHBul8JB5u2BQnpvmY1geJy0GGANz9by0kDobGsDN01p5V9ju93
         pTGNiTprCbZwsOOkHEhi33+qTuzUQeuoyJ5ZcAEp2aolTcJ2ZvqJD2z6QP4tQgO0LyBe
         HfcU6AM5L0gEeewFiu0tgq9SjXNNGeCMxIBvHMEHbUOSLvXl8cUbNVfixMmBKM8yjjYn
         KP7g==
X-Gm-Message-State: AOJu0YzFymeEp/EMK0x3agtCvNxzhZDkfKIYwoCSt2msp6mOc53a9WsV
	kfqqIcr3kkXM8WQukIycyLyq/xQmAm20yzlzM0CB8TeF0H0vXOfws05zeqU9Ug==
X-Gm-Gg: AZuq6aJloBEbuaSr9tlUKKwSiZPqQgfT/4vKYkcOPu8C3w8ujfLZuKnxgO81VHeF15+
	fFRxX9Irri09Ovp+5jj5M5xaAiHog0PWta9sGvQJRgiwEvSagibK9rNDtzRuDmaLcoZ0mquGHQm
	uhqeIrmaE5bmNaMhIEZCM/6b8TuCxEcLEPCqz04QXBZJjUw2bAw7LFMEmEMfq95HBTF8YX7A/gZ
	tRZT0tw4PgtKUAo6UIg0le7IB4r3/eWp/AOaTdQBb77DjYHJTre30/IFPkXbqczIr1uNCVveyay
	6m4guBWz++QnVuaDvx3k68xGK7JUD8h/IxMn0NgqTThGV+lMSpj0rxjLeWGTk4J4cwuglaiJ0Ls
	6HX3ViistB/zyOrj8AijQTe8fRBLNyRlAIpS9/9GB5UoLp4W6kNwtk7yeYgC9Kfbg3rgdbOBYMr
	DUf3NNsDf0W87JgDVCKXwIulSvqFPAUgOGH5ont2DqXO3e3hxZcOCDxG1wQQyOTEQdooXJHXqtI
	Og=
X-Received: by 2002:a05:6808:5284:b0:45e:a68b:30fb with SMTP id 5614622812f47-45efc6d0ad5mr3350885b6e.47.1769622115990;
        Wed, 28 Jan 2026 09:41:55 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69e63esm2127754a34.11.2026.01.28.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 09:41:55 -0800 (PST)
Message-ID: <5458dad2-27ec-4826-be91-4fa5428a8f11@gmail.com>
Date: Wed, 28 Jan 2026 10:41:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
 Yi Zhao <yi.zhao@windriver.com>
Cc: mingli.yu@windriver.com, mathieu.dubois-briand@bootlin.com,
 richard.purdie@linuxfoundation.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][PATCH 1/1] openssh: Add pam_env support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 17:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3139

From:
https://git.openembedded.org/openembedded-core/commit/meta/recipes-connectivity/openssh/openssh/sshd?id=4e6762f5967b1996cf31ae100fa49e775dfb2866

Make setting environment variables in /etc/environment or
/etc/security/pam_env.conf take effect for ssh session.

[ YOCTO # 15767]

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-connectivity/openssh/files/sshd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-connectivity/openssh/files/sshd b/recipes-connectivity/openssh/files/sshd
index 72303eb..06d4e78 100644
--- a/recipes-connectivity/openssh/files/sshd
+++ b/recipes-connectivity/openssh/files/sshd
@@ -15,6 +15,7 @@ password   include      common-password
 session    optional     pam_keyinit.so force revoke
 session    include      common-session
 session    required     pam_loginuid.so
+session    required     pam_env.so
 
 # SELinux needs to intervene at login time to ensure that the process
 # starts in the proper default security context. Only sessions which are


Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8ECF45DF
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 14:58:43 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.60657.1768316319224009047
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Jan 2026 06:58:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XwCvj1I6;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450b2715b6cso4448502b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768316318; x=1768921118; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvFkH5VkeeMxYqjiEkXwufT3bHZkWdtwVnX0I74rRqk=;
        b=XwCvj1I66wlwk63cNiX91cFp9U6QiNnVNYzEvLM8yY4xAIPLH4uhMxmCw0Q7b1Lbyn
         25lr2kBuD+XOYG8mZ0OhNF1nrVm6/ar06meyXzvG7ue4XGRYIVvVrG41c8GzUoohTn2U
         AR4tq4XP+dmia7bG7TIEADH1bsEN/RR9vbVY/HM9VLJmrqBvRk8oB3TXC0TemWaWVeas
         1JC+JNj3c4ZDkooJz7f8qSRAZhcwhCxnLZMgzhK2wkgDGaqqtoBMRsaoRIigGR10o0FO
         WJ9XKH0DC3biH//+lIYV4vPNScpgWMkITo4k0biznRKPBVfOcMi+3vVivpNMwa0XrS7n
         gdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316318; x=1768921118;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvFkH5VkeeMxYqjiEkXwufT3bHZkWdtwVnX0I74rRqk=;
        b=FREDhPTTepjDzXtu5JJ5DIA0BUQ8IUCAM7vQSQl+AwwLScoOxk4jOqChwpUecR48HQ
         NqDiqr8QsS0zX0+OxTPJNvqdhOPqxYWyxriskTKNStW02BeyzcfI91gscdHDBRCb+GCl
         Jg8nVzfzib6b6hF7bWfWgi2jn/f+IpddNaW+5C0TB8c0jxZhgQ4krRKN+0wRGWO014IF
         jsH6ubMvh+4MpnWxL3q7bMet6oVl8FBrt2BWRdfPu9wUTbgAjWnbvDtcRnHytLH8PPmi
         uopj2ahPDE+0P8D1J79fyHk4pP93efcL0yt8HN9CqQJLi4Z0TjqktdFJ0xKuXPsvpl2P
         H3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSvgYU0aaLPU9i7l/bjS2e3P2ArRIj6XOQqqFyDbZArv+fL/gjGpVkFSY+Tq3hHKCLVZPxY9RuAozJtwbI@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyxETTaiPpKdkiDQK7Iu1S5sUGQHaNquzpz/xYOg0qAPPu7OpiN
	/UXSfhzNTcsBFpjVXqwWCdCGBT6gnoH2BjkXzIIUNCPcJcFwrBNpkxfO
X-Gm-Gg: AY/fxX5hNbVb9I5/PVPz2S/E4PVRzZPq+MzkLD+qMOyHYMqQft1GeSnD050D0E2aPJU
	OWqJkQPhjjm5p8eOiUk4kxu+gl0SqF+0BDluQ2grJjDadhfIAqhlG8wuU4FATZ0OA0WAQfxoYwU
	0MbGqznZC1Hd89hEy2uMYnoHjXYlAaPFcgBu3yONS1E1Z2AMlmF6GNi/2qGBGrwCide3AHvsgbC
	u6v9mKahq+61/3yXPM5H79HU8FYeqxMzAWVgKvxH6o34cmq8gAxlQQ2kOgb6pnSOF6W42ZeVeR4
	rIaHhNVniT2r2pR7hPjIHpJfhwp7+iW09HHdveIO3cGRm+FY1c6PZ39rB1tYFvezk4XKxEUlLu1
	EYn6QMJbaXIapcRA0M1J5FbBpEjyM6Tp2vecGA40c5CLZyLvGb08LZE0lOiAlXxakroNr7gSntp
	V0luPykaauruc41ojBpLhGeoIN5/ZBYmiUkZdH+C8lDSozt7q2NgMbnaDQnwF2Qg==
X-Google-Smtp-Source: AGHT+IHZPXoysuNlTK7Eo81AC62H2H8GzCyY0PzPNs160ecJGBBiqnm0ngzj7YtWn3DEI1jzj055HA==
X-Received: by 2002:a05:6808:220f:b0:43c:8714:fe3c with SMTP id 5614622812f47-45a6bf1a361mr9225790b6e.51.1768316318408;
        Tue, 13 Jan 2026 06:58:38 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a76abe858sm7597609b6e.9.2026.01.13.06.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 06:58:38 -0800 (PST)
Message-ID: <28cfcf5e-2218-49bc-975b-365ae4117934@gmail.com>
Date: Tue, 13 Jan 2026 07:58:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
Cc: alex@linutronix.de, alexandre.belloni@bootlin.com,
 richard.purdie@linuxfoundation.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] shadow: remove dependency on
 pam-plugin-lastlog
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 14:58:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2950

From:
https://git.openembedded.org/openembedded-core/commit/?h=scarthgap&id=04f3c3e335bf5e7c3a12ccc97fda9a8c214135d0

This item has been deprecated in pam 1.5.3 and is no longer
built by default:
https://github.com/linux-pam/linux-pam/blob/master/NEWS

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-extended/shadow/files/pam.d/login | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
index ec5bba9..1c3659e 100644
--- a/recipes-extended/shadow/files/pam.d/login
+++ b/recipes-extended/shadow/files/pam.d/login
@@ -64,10 +64,6 @@ auth       optional   pam_group.so
 # (Replaces the use of /etc/limits in old login)
 session    required   pam_limits.so
 
-# Prints the last login info upon succesful login
-# (Replaces the `LASTLOG_ENAB' option from login.defs)
-session    optional   pam_lastlog.so
-
 # Prints the motd upon succesful login
 # (Replaces the `MOTD_FILE' option in login.defs)
 session    optional   pam_motd.so


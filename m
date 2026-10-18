Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD30CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:53:36 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7914.1792288410441281030
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:53:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JH0g9jqZ;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so888139a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288410; x=1792893210; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WFhBdicCbMPynwyGXJdd+OjKRJJKHIIaiL0w35ADKUY=;
        b=JH0g9jqZlaX50B4NA/HAKkMXZK4WgTUxKfSsQ8OxPmdYXMeOSejPIIms4C69GUXbN0
         Zjb+BKea+feKRAxXtZ5xWTS/6JS/9wkhrACx2mwrVul6As13blDHseKu2NEUWTPyzeom
         3K0u3NsTvwCYmbuZuOsoNaBacrKRcP8gqPP5CWxilUhux8qWBG67oAtb0WLS1MWq6jHe
         s7sdk2yg/XGzYZrYmTKATW60YToLOfLuzwQLTdk0zHSWohpX/8FFXLPjStOOjHGKbybY
         GIkQS7vToQvmW80VR6jiIDD/ro0rcAJACGJAnkbKZFqOy4qf9UqPJJbi27D9f/wt/gI6
         S5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288410; x=1792893210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFhBdicCbMPynwyGXJdd+OjKRJJKHIIaiL0w35ADKUY=;
        b=WJF4MRptw+1i20wxgGQPmfNNklQ4iliLTwghvpiU5kTN0Kwjjo3TCFekg2yQOPuHT5
         PiHejadC1iTwcgu+itar2FSmOfxylaXD6+HKoPVLpgTwEo7xwHF9P9eCmqictttQlpqj
         Fq5S18+2gor6KgtvT05xfRikeekBPcR3jiIp7YMRwcdx3bkflEvR2/aIpLgb3p1IoC//
         IVfDIzuYLbBZwoQ3chp6R8nQuw1KwIrgN+xQPLu0kJaTj49HOlVIGSNXDmFyzHs43K/X
         8lbtZySIJKxDRFy5zE7od+jEEeTtSva3C3T3Azuh/01TfW2MKIHOK6Erm6DDYylzSYKL
         oIRA==
X-Gm-Message-State: AFq9FYJSMBMZSrHQji45PFNiBJIphlxe3ygWYSr8BimCb8B9+IVRYbLx
	T2l2MQiQpPHFNmF/evppHLH9lar/omCjk53IvFRVyydTI6u4UB+yTHZnqtXLWx/Y
X-Gm-Gg: AYBFou3bkfcOOW9CaumnWRYR4wh1WbXdsHhDGY8fzO4oQhaHBH3pfWytH78LzSSbJri
	PKExrAKx5MdIWxrMSA23xAfmlh4FTB27PqBRZ3WSVWJuFclCN0koqYpzS7H41r8IyYsrUA2Jt9h
	EpBvCBypdCzF78FN3iIE4fVM/613Uc4xjHuOx4AedZ2g/FNoaOZEL5RpQScfrgWUxkgJriQZLuF
	1qr57ixsmXiLSw53AqD/vvyZ0o0f53nw88Sv8OLmDu7TsLHphQc0dcK3yWHlpNwP+5c6fovV0r2
	rN2tbfK4Rn3kfHtrP0kMzcHEXpUXHPrRHT4j7v1hpxBViQCPJVoloKZRRyglFv7pn2Xx6BOPbB5
	6zSv4Xk3i4yNMpbQV/OZXidI5mslYmpbhQwGbO/PCxpvQJ+KuZch71X+Stisf/EMTEs41BVh9hN
	ZjW95BekzSC6MxZm8Kj2M9RQ2UDdJHT31Jy112EXoO2AhrIkbDEP+HeM8lwdLFXnStKFlD///qd
	ZnNnpZUn7vO6dsjHmTIGzBw8EDes+M=
X-Received: by 2002:a17:90b:3ec2:b0:3ac:80dc:f406 with SMTP id 98e67ed59e1d1-3acef4fec85mr3521453a91.50.1792288409604;
        Sat, 17 Oct 2026 18:53:29 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51b5sm24626155ad.8.2026.10.17.18.53.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:53:28 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/3] Minor fixes; drop broken account pages
Date: Sat, 17 Oct 2026 18:50:34 -0700
Message-ID: <20261018015326.73748-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:53:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5054

* common_context was not being applied, so fix that.
* The account pages were broken and are not used in production, so remove them.
  If someone wants that feature, we can add them back but we will need to fix
  them and more importantly add tests.
* Align the README with sending patches to yocto-patches mailing list.

Tim Orling (3):
  Apply common_context through TEMPLATES.
  Remove the broken account pages.
  README: update where to send patches

 Post/test.py                                  | 21 +++++++++++++++++++
 README                                        | 10 ++++++---
 project/settings.py                           | 10 +--------
 project/settings.py.docker                    | 10 +--------
 project/urls.py                               |  3 +--
 requirements.txt                              |  1 -
 templates/base.html                           | 21 -------------------
 templates/registration/activate.html          | 18 ----------------
 .../registration/activation_complete.html     | 14 -------------
 templates/registration/activation_email.txt   | 14 -------------
 .../registration/activation_email_subject.txt |  1 -
 templates/registration/login.html             | 18 ----------------
 templates/registration/logout.html            |  6 ------
 .../registration/password_change_done.html    |  6 ------
 .../registration/password_change_form.html    | 11 ----------
 .../registration/password_reset_complete.html | 10 ---------
 .../registration/password_reset_confirm.html  | 21 -------------------
 .../registration/password_reset_done.html     |  6 ------
 .../registration/password_reset_email.html    |  5 -----
 .../registration/password_reset_form.html     | 14 -------------
 templates/registration/registration_base.html | 12 -----------
 .../registration/registration_complete.html   |  6 ------
 templates/registration/registration_form.html | 15 -------------
 23 files changed, 31 insertions(+), 222 deletions(-)
 delete mode 100644 templates/registration/activate.html
 delete mode 100644 templates/registration/activation_complete.html
 delete mode 100644 templates/registration/activation_email.txt
 delete mode 100644 templates/registration/activation_email_subject.txt
 delete mode 100644 templates/registration/login.html
 delete mode 100644 templates/registration/logout.html
 delete mode 100644 templates/registration/password_change_done.html
 delete mode 100644 templates/registration/password_change_form.html
 delete mode 100644 templates/registration/password_reset_complete.html
 delete mode 100644 templates/registration/password_reset_confirm.html
 delete mode 100644 templates/registration/password_reset_done.html
 delete mode 100644 templates/registration/password_reset_email.html
 delete mode 100644 templates/registration/password_reset_form.html
 delete mode 100644 templates/registration/registration_base.html
 delete mode 100644 templates/registration/registration_complete.html
 delete mode 100644 templates/registration/registration_form.html


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
prerequisite-patch-id: 9c9d012e1163dd1d335531d0451657823f17eb64
prerequisite-patch-id: ddb4df3e54736ed25846f91d4918299e601f4071
prerequisite-patch-id: ab69f4aa494291611cbe0e916f18b07f4aeebe57
prerequisite-patch-id: ac2b802ea065536df3854c48e265f5508d201cff
prerequisite-patch-id: 81a7de0e9568848efc8c66d397abb5f56218db95
prerequisite-patch-id: cf32dcaef20903890a020211a35f46b2384207da
prerequisite-patch-id: 6920bc5c70071bbd42b55b08bfc2bff04133c3ab
prerequisite-patch-id: a72bee4356db80ccb45321967d18081961f60860
-- 
2.56.0



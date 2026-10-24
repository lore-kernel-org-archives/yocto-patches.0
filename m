Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14414.1792880808658506285
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 15:26:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sSLBvE0Y;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e831e86ebfso11490985ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792880808; x=1793485608; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYCL91khBP5+zYHld9i1M0pL+BTRhtvo9r1ws5ygyRc=;
        b=sSLBvE0YlctZmAZ9TZ+xcFYpuxX7KrIqeEJNVZp9pFDwtID3uQxOeQTIrWxNHLvlUK
         +UCcgN3YhrTASXo+K7er+WJqE2+/EYaFRmQ0k/dFe1qoyxa0buWIOlx7Bc/Mzlwz3BWb
         e24yU/8z8qly0Re3ByBsdabxzMZYw960ls6rV5VyQkYJfJjZVviNg1aYGPwvPIzZ7Oc6
         dCSvWnVIVpbZqYN6UEKvVGVjL134orFitZvupcUZ50mszxJiRKRl3u1tUe28WXu/XgYt
         M2k3OmkamZEjFfoJMGu+QeQ9eUJfG51r3U/v02Nsg4JwWmtHew5zvuifbEZ/z0A9NP5j
         TThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792880808; x=1793485608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYCL91khBP5+zYHld9i1M0pL+BTRhtvo9r1ws5ygyRc=;
        b=who2xs1QmHNkjc+xXGEjnN71+ql9+gufkU9KAMsNVUmpsCBuPNdTyZbj6x+QEE6iAS
         6LKgTkNGCT/pjLS8O/GYwhHCl6WHFP000FqnMKIkKNOVgKwibGHWEpNCHVtRwmB56mfq
         HZ7duoAYflNaayBjYAUNqvNghxIuPqTxW7pE5OL/G03h7UatljFWSCma/EhZh2aDxF5h
         JrdMIERxYghh8EY9mQo2ueYtFTom/SrMQEAsnxaGtu4+ywuCwcp3lcGKDq9Tg32Dc8Ip
         jeVfDq1IMDEllPK/VMLGuxdT1JRoGysQfMIKb7r8CN/OJ4U3fBQGcQVQ8T14DaiWErgv
         JWzw==
X-Gm-Message-State: AFq9FYK1w1mhp+JByYqWoEzJgXvP3qwYeJ+hNjSe1HeuQ9qc2Z6FwJZM
	skqBXKa8j4mN7XCY/+WqvqArEeS1aD3IWF6BtKFsJEXO4g+x49lpOnETjv7c8Q==
X-Gm-Gg: AYBFou2wYe1yXo/Zbts6q2/g1rDHsYvoB/JJ2X31/2IU9miom7KlKNzukzLhFfmW8Ul
	RoAofvU9XnZF8fYGmHFjsHq9H5chC1nKNWbnQz1qjrCQBXz3/O85z4MsOKHXPXeQ1RJFl1d6eGc
	tbau3b/lurtYSMAx42dy1OBwMlWOaZFerRQfxZRRcMTC8AjwSFKAVfCyRKJDcDIavt4QDd6Kz2d
	TJygfQuvtKN618yFAq0koffE9AAj7Txx2gorP0enMbfk+PG2Ffvy89z9yGQoo28I3h+/fi6F/Kt
	QKhG0AkIR30C9c517Kk6zK2f9BhhhMY8eS2QY+SoZhknneVWEPpBR4p9gsv03DVQxdOsJFVqyy2
	ZRbDFEL/gl5OV5zFJMamuGBkcCcFvCOvzmh8B79eqlVMOS7LNznEe17tvvlZ9H6r/44Jdw6tMXH
	EyVLwPCcWg2Xnn7UbDoAYlKunRipC7YnRnkGxzleZHLENEZbjW28EUJD37NA9hIuU1CqZQolCcn
	BiJR74nHy4TVZGcbFAtw7Ft/JSD8aLOcHJIrgRt4Hev3wA518dXsvy8N7Z1S47uTvHrce7PDoHH
	+InDEK6siOsu
X-Received: by 2002:a17:90b:33cb:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3adeae80c34mr2732219a91.52.1792880807952;
        Sat, 24 Oct 2026 15:26:47 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe9078asm3725209a91.10.2026.10.24.15.26.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:26:47 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] requirements.txt: upgrade Pillow to 13.0.0
Date: Sat, 24 Oct 2026 15:26:33 -0700
Message-ID: <20261024222633.84011-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024222633.84011-1-tim.orling@konsulko.com>
References: <20261024222633.84011-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 22:26:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5148
Content-Type: text/plain; charset="utf-8"

Fixes the advisories reported against Pillow 12.3.0. Pillow 13 needs
Python 3.11 or later, provided by the move to Ubuntu noble.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/requirements.txt b/requirements.txt
index 3da41f9..f445b32 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -26,7 +26,7 @@ GitPython==3.2.1
 kombu==5.6.2
 mysqlclient==2.2.8
 packaging_legacy==23.0.post0
-Pillow==12.3.0
+Pillow==13.0.0
 prompt-toolkit==3.0.53
 pyasyncore==1.0.5
 python-dateutil==2.9.0.post0
-- 
2.56.0


Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB1F3D616
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 17:11:28 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33125.1774804282477462226
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 10:11:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=AK1mA1sZ;
 spf=pass (domain: qbee.io, ip: 209.85.208.177, mailfrom: piotr@qbee.io)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a2e62b893so32804511fa.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1774804280; x=1775409080; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDgjUS6fCuKETuz9IUfLTTUaD7VOWv6wuooEvdyyZL0=;
        b=AK1mA1sZDAlH+wFCV9rseiiwxmBWxZuzE49CAXlrRo5nJxF3auuX1P/FChOkcn1zXX
         pLmq99YT1/5ekO0LtFRuaVKaTUX2r66X6jjONLBXwVsOmvGVrVk7ZfN1IkJwT76kS+bL
         +OPR9geK5WYQoMK4voKCUDrqsKnPAWggIuVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804280; x=1775409080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDgjUS6fCuKETuz9IUfLTTUaD7VOWv6wuooEvdyyZL0=;
        b=Sx0rjAqjYELeVQThpk047Va+GpHWpNQXtde6NbD19CKiJjzevRX3shBkoWTv92Fdi1
         AkHww4oYnH0vKad+JnBQ0Ebeuw2TyecQgd/YFTM/nUN5yWRvyezw0bp7E0pIgGI9QBqo
         3vw0JDkXiIhvEdXNJIouZlM/plifuQdm0bVB0HvwhjxzTijGDhW5IXHgdJALPXF/aUUt
         TSFS9efbXVotWwxpAtZzlF4fWh2VldTw+STraQc6Jetn7XvG6eQ7ineTUfcpG/y8vyVZ
         pLdVgUiQHrx8aKDbexPZlRRe+yZ/iWMwphm94OugagB7J4H9hLKqHJwMuLnTTXCx29K7
         od+A==
X-Gm-Message-State: AOJu0YzA+QA2t0C+sZANEQE1u2FVNCzqreMGOFZ48os7qR9NcBRRRBP3
	sUrDJ4KsgP0vsqijYynmCrcDUeFEY4cyUXoDUzFqmtsu11ATht/SLeyJwTNZ9asr1Rl9BpLpAm3
	Cuo8O0au5Qg==
X-Gm-Gg: ATEYQzzZ5dmQp5r4gwsrzwja7VNq7alT0MtB6wA0BgnUga+HoVnW/0vNCx46JVEHaR3
	WjKlFit+vRi2olczAzI7EGX+vKnWyxSJIVPwalhjPCA2ANT/R+v3wciPgAJV0p6DFK31wPtsata
	OctKLeCmbYh1RrB8VIdm/p95kQZcw70BxHhYKASC+sTp6Tg3UsMJbj68OwJ/+zZ2hNwFyokpKG9
	3cm3ys7Acbf7Z1cVj2CXaNQbbUJ8rMSnNVyCklpbBmgPn9FgUaiER5cHQ2y39FUn2VRKxd49VEe
	caUhBdHJup9fQF88SIE70DamJodeJEAk/OTWqcvZknC4K58QJ+VmdHDU/Oq3ormG1jiVUPlTPKs
	gZClpXigfC5gJlLdx3mUuxQclzLbnpQN2Dv0WmJKGE+w15DsGJ77jQjiCNPaIWd3HQ0Yn0j194j
	0+IWlUy0b0M0yxEPA3Rtt8XJxFyUNm0Sm+3yBZIVJbruX5ZDHW7qoL
X-Received: by 2002:a05:651c:f0a:b0:38a:347c:4e03 with SMTP id 38308e7fff4ca-38c740342e4mr32206671fa.34.1774804279847;
        Sun, 29 Mar 2026 10:11:19 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-38c838ff4c0sm10651501fa.39.2026.03.29.10.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 10:11:19 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 2/3] Update settings.py to work with Django 5.2
Date: Sun, 29 Mar 2026 19:11:08 +0200
Message-ID: <20260329171109.34764-2-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329171109.34764-1-piotr@qbee.io>
References: <20260329171109.34764-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 17:11:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3576

1. Remove USE_L10N, as it's removed since Django version 5.0
2. Set USE_TZ = False, as in Django 5.0 the default was changed to True

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 docker/settings.py | 6 +++---
 settings.py        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docker/settings.py b/docker/settings.py
index 9a96e83..fdf09de 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -45,9 +45,9 @@ SITE_ID = 1
 # to load the internationalization machinery.
 USE_I18N = True
 
-# If you set this to False, Django will not format dates, numbers and
-# calendars according to the current locale
-USE_L10N = True
+# As of Django 5.0 the defaults has changed to True, so set it to False to avoid
+# timezone-aware datetimes which require more complex handling in the codebase.
+USE_TZ = False
 
 # Avoid specific paths
 BASE_DIR = os.getenv('BASE_DIR', os.path.dirname(__file__))
diff --git a/settings.py b/settings.py
index fa303b1..bbc5aca 100644
--- a/settings.py
+++ b/settings.py
@@ -45,9 +45,9 @@ SITE_ID = 1
 # to load the internationalization machinery.
 USE_I18N = True
 
-# If you set this to False, Django will not format dates, numbers and
-# calendars according to the current locale
-USE_L10N = True
+# As of Django 5.0 the defaults has changed to True, so set it to False to avoid
+# timezone-aware datetimes which require more complex handling in the codebase.
+USE_TZ = False
 
 # Avoid specific paths
 BASE_DIR = os.path.dirname(__file__)


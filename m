Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1887.1794612498767864895
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:28:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=TUliGALA;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso706110a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612498; x=1795217298; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSIKjSSWZj3gO2HyHo9P3nXqSSLQGHmKCp49MHLPs00=;
        b=TUliGALAvEjnJQYrNKIe9MZp8+21uMLIg2QU/oemiZP9LFFJByfPJSJ7l2qETrmMqV
         KMJsG2YtaA5ayWYYtRAPbQOqvs0sLRshT3Y4C9YuHXM5dtMh8h/o9ky0PWCO+LiNx/6J
         oS37/Fi+xIavKgVpz0jPqtScu/pPSWHxRbnL5vLRm1xvnGYmF/6NHkON1tuD+06EaCsI
         Nlww1c1vL80rdd8aDh2c+nuQ6bSxBAowwoT6VpV9WJYt+jKdVIQa+Cc1cVhDJ0Rz9Fdp
         GNwI5CmdZ2JFq3tk+79mpFR6TLgAyWu0kAn823TPAzBz+slOZJXXlWIoWGTrnvO4tEwF
         N59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612498; x=1795217298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSIKjSSWZj3gO2HyHo9P3nXqSSLQGHmKCp49MHLPs00=;
        b=HOeB0AzsTynRA89MbVKQejUQxN6NkKt86Ytab8dhfccbmIZXkOfGez7w56mDsl7Mlu
         kvoHolT215hvG65u5jv1tmGpIlLLTe2BgcUSAQMW4ny9Ku6ofRM+5Vv8gF8ZZDFLT8bN
         ObZuCMBmRMZIieyHiZDco+2cf/FV/c5p7Ith1Br813+7SIORBq3MwBodxhbQOB9QqjG6
         uLXFcCfiYMfgxBBPP68jd+BtxRFxPD8OISBwTPCYceOBBqRmdH75dLUn7TEOb1ODiSvy
         iX6u6P9lVpg0OIvTAuw5N4DBMXVLDao4xnbS2oq7/nToQpm1+PZ7pNu8rr3+xfj044Nn
         oUuA==
X-Gm-Message-State: APuU4Z970HyXiKXWiwwkV8pR1LEtqEZXC8swzQdjjdxYfcGJNFLFcJ2n
	vnysFtEimC3ELz/8zKnx/odLD1vCghiouDKjS9v4mQmX+0E8m6jfnwPNmAsu0nW1
X-Gm-Gg: AYBFou2O6nT5LxLHNmVZ/y1YFN0ZxIfwcAGjm4UfibEBtmm489LhHwYf5zO2KPrKdCn
	i/HwC690r/1SjILKWB0jRq7Fki+CZGJpJ9uS54Cv5NktBkh4AJHJJoKWwmf1Igbb/DftJOcxv4x
	SslmzBuz1PQoWEWOq0B2AG87poSmoo5Euw9pY40QCsE8NjpTHodip+4W3MSSBfbd8SY4JAx5RZj
	AKIe0Lj0KoqOm1UlPvaT/wCVS8/RrpqQGAik8UpjtWvsWvh/0sx3czFi6Or3mnOUhx8NjDKH1Bi
	XJBeQFuroRi34kAXn8aigNgRnOSm34XqEMKBb0nJzaKClhvFDtA4Z141kaW7PPuOTAKzFRYTMoY
	AijbFarw+r8TiMQ0N+12+Mr5Eqel9pBeTJGKKYlWi4QFe1KWCFPzoYKcxbWQupuYrV5EHRZc1Ow
	WTnwfQGY2VLw6S85VoxLlMKdNlT+etISGpm8Sy4OxS3g3dh98nFlJem6df3fXzvykUWlCBttrdR
	MkOjV4uQUmT335eSIANJMkBIfpFdj6M/tRpUBqKslhbje+/PRSafpR7tmQQRblsnkWrbPq15FD2
	Vfnvz+ePhlgpwT9UfsbZ5qQPUCHgSwJo1+l8i8mMi417aw9lbfjgldQWSsNNig==
X-Received: by 2002:a17:90b:180b:b0:3b0:8e66:1205 with SMTP id 98e67ed59e1d1-3b197d7cc87mr5812865a91.31.1794612497911;
        Fri, 13 Nov 2026 15:28:17 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm1279789a91.3.2026.11.13.15.28.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:28:16 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] requirements.txt: upgrade soupsieve to 4.1
Date: Fri, 13 Nov 2026 15:28:05 -0800
Message-ID: <20261113232808.96792-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113232808.96792-1-tim.orling@konsulko.com>
References: <20261113232808.96792-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:28:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5340
Content-Type: text/plain; charset="utf-8"

Fixes CVE-2026-126190, CVE-2026-126191, CVE-2026-126192 and
CVE-2026-126193 in soupsieve 2.9.2; CVE-2026-126190 is only fixed in
4.0. Soupsieve 4 needs Python 3.11.5 or later, provided by Ubuntu noble.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/requirements.txt b/requirements.txt
index f445b32..bfc3466 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -33,7 +33,7 @@ python-dateutil==2.9.0.post0
 pytz==2026.3.post1
 six==1.17.0
 smmap==5.0.3
-soupsieve==2.9.2
+soupsieve==4.1
 sqlparse==0.6.0
 typing_extensions==4.16.0
 tzdata==2026.3
-- 
2.56.0


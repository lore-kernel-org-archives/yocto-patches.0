Return-Path: <halstead@happypunch.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72232E88D6F
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 21:39:44 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5604.1775252379181437959
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 14:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@happypunch.com header.s=google header.b=Vp/9RbtM;
 spf=pass (domain: happypunch.com, ip: 209.85.214.174, mailfrom: halstead@happypunch.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso10371245ad.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happypunch.com; s=google; t=1775252378; x=1775857178; darn=lists.yoctoproject.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OD2QbUjfIBvJnKXxMDE2P5gQQ386UQkSRhuOyNo8Fqc=;
        b=Vp/9RbtMIwQ94jIHsbqEo0efxj+Xn9mLpHQZv4VOUGAT5kR6jy2uC9TmqVtZGjZcoi
         I8AJXBaksafK/jrG2wDov6pnSOfwTLPyj5hyawjCd04r5LOEaG1EEb9msZE+ynkED9GO
         ZGI/jIlVeoEZYOInUZriBGJKEXNdiZgRbO9f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252378; x=1775857178;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD2QbUjfIBvJnKXxMDE2P5gQQ386UQkSRhuOyNo8Fqc=;
        b=sbliBuSrFhmR7g2mWBR0AGTEqUkGrHfB5K9/l8kyimZiFse/KgVGVyQw3HBzwcdWCT
         ighM0ritetm8ETrW0L/mKOzBIFFd5V/Fw7STVNAeHMst6YtKYJIit5BABv7twFW7ucwE
         f+ItL8FlBoGWZNy/PQbSCw8uUY7sX7dFGqVyJ/2ha38/fq4nLhbpF/ZWx0+NbGMHHplF
         KWrJ0Po03hHxWYRK9iXxJ/roLaKNOpbz1N61YeQw6eF0V6SE0EwMn+O+2X1YEXIOQtqx
         9BEqee4cXGsBYAj6pJHMhqZhXl6d1XSGhPVdx9TnnRSVRQdNLpzCtCfyzevhygELcodR
         vrGQ==
X-Gm-Message-State: AOJu0YwpJivxY4Y4XJQAPnPgDTTYcoAfYPNJdCXZSXN+eDlmP6t5JltF
	2IRZ/a4KlXaATjb9wJYjy+5Y/PSOViR0NFug+6sHswdxQSUCFm939Bbjs61G9HlQUbnvGowZ+nQ
	ooGXH3w==
X-Gm-Gg: AeBDiesBYnK/3o/T7PwUoBjZATqU98nVWtG6Ef+Q4AOD2OCQk9z6Dhh2KAOXTZTqbeb
	Uw0+1KX6kTm7I9p01lE4eutc1iID0jmlmP2FrKS3u3FHqsqUeDX0f0d6XavuZDSeKBCklQsTt+m
	50nKBt41J3LPY80vEaeaRsiQDGB4ZDYycxLBOr7snuPbid4OJxygtYhnT7olYtH6FMLle8c8DuA
	9lC6ukkV0MrhFgFgvTJ0d8j6L9n9kkTBjvfhJnplxRiXbyrtuVASQ7di/FvXGOHk+21VJy6rPyl
	ABV4IWikihxHCO4wU/BoQpWrvmlRl3k6uqPX94bEhBixeXC4wMAiCen7nKfOYU1HGx74KG+0vOt
	2/vIdwynB4mvnUDcadoe35nNeGJYJVfnAJYw8i+H5+O6zsLvcD8O7EiTn0enKmTP32YYFb/ODNE
	+Yvjz93O9S/12TIUzItqOEmg==
X-Received: by 2002:a17:903:b45:b0:2b2:54c1:2067 with SMTP id d9443c01a7336-2b2816f3dd3mr44600735ad.21.1775252378289;
        Fri, 03 Apr 2026 14:39:38 -0700 (PDT)
Received: from [192.168.0.122] ([2a02:6ea0:d802:6232::23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm61963335ad.56.2026.04.03.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:39:37 -0700 (PDT)
From: Michael Halstead <halstead@happypunch.com>
X-Google-Original-From: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [yocto-autobuilder-helper PATCH 0/2] janitor/ab-janitor: fix
 reliability and security issues
Date: Fri, 03 Apr 2026 14:39:20 -0700
Message-Id: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQ6CMBBEf4Xs2U0oGA/+ivGwWxa7BFuyLUZD+
 HeLHmcy894GWUwlw7XZwOSlWVOswZ0a8IHiQ1CHmqFru0t7bnv0KRZTxkBzLkIDEuNEUUsypJF
 d34/inBBUwmIy6vtHv8En+ZKQ1pJ41XkQwyDzIgb3/zKvPIkvh+z4MmVBNoo+HNWTqs1g37/Vp
 qr7sgAAAA==
X-Change-ID: 20260403-contrib-halstead-ab-janitor-afb133fe11ea
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579;
 i=mhalstead@linuxfoundation.org; h=from:subject:message-id;
 bh=F3Cmj/UTtGZiAsTBx3T6nD7LDo/YLGcRM9mj40b1pYw=;
 b=owGbwMvMwCXmG1QSm3K4rprxtFoSQ+YF42lv/kRF71F/FnHU9MmO72uWin45/eGm0v6615vmn
 lrz882hio5SFgYxLgZZMUUW3UvaMYnvYjUma5mlwsxhZQIZwsDFKQATebKB4Z9K74X+prLfevum
 Va1+E5sken9nwqtdT8U17v9ZIf/apEWckeHYjCz/vx1ae4+XKcXsn9a93U/d8sT02iiZRkFvvXs
 mSdwA
X-Developer-Key: i=mhalstead@linuxfoundation.org; a=openpgp;
 fpr=D1F2407285E571ED12A407A73373170601861969
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 21:39:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3637

Changes:
1. Handling invalid pidfile data:
Previously, ab-janitor could enter a stuck state if the PID file contained
invalid or unexpected data. These changes improve the robustness of the
startup and exit logic, ensuring that stale or corrupted PID files don't
block the service from running or cleaning up correctly.

2. Modernizing calls and general cleanup:
The script was using older os.system() and os.chdir() patterns which
posed a shell injection risk when handling file paths.

Switched to subprocess.run() with list arguments to bypass the shell.

Replaced os.chdir() with the cwd argument in subprocess to keep the
process working directory stable.

Cleaned up technical debt including bare exceptions, variable shadowing
(file builtin), and unreachable return statements.

Corrected a misleading comment where the math (120×60) correctly
represented 2 hours, but was labeled as 30 minutes.

These changes have been tested on valkyrie and verified across the
cluster to ensure the service restarts cleanly and handles the current
autobuilder environment correctly.

---
Michael Halstead (2):
      janitor/ab-janitor: handle invalid pidfile data
      janitor/ab-janitor: modernize calls and minor cleanup

 janitor/ab-janitor | 78 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 36 deletions(-)
---
base-commit: 83d86624149fdded4fd4fe20824d391d0b9bc855
change-id: 20260403-contrib-halstead-ab-janitor-afb133fe11ea

Best regards,
--  
Michael Halstead <mhalstead@linuxfoundation.org>



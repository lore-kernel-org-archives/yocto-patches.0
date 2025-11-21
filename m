Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F753CFC506
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:34:38 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20917.1763757269485185384
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 12:34:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=VQbP42+H;
 spf=pass (domain: qbee.io, ip: 209.85.208.176, mailfrom: piotr@qbee.io)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a33b06028so23008711fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1763757267; x=1764362067; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHCb99yc8xsVtaE7ueh4PmfEo3Jg8lD0bk5QN7CHIRU=;
        b=VQbP42+HrAVQYvdxR8tRXrHZ30G2T/7KTBW/w5j958df2A2kDkcsglA+iwNqYiQkhA
         uOAjWzFGvfRQ39y3xsQzZ3NFK3Lb7tNmdwhuEqVx6jEOZnxkk6cBHVnP/aEBud6jPD31
         dN6i5xB2kdQClr0qBPlFuYyi2g/v/FHfEFVt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757267; x=1764362067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JHCb99yc8xsVtaE7ueh4PmfEo3Jg8lD0bk5QN7CHIRU=;
        b=G1H8T83zAblu6jJPJAHPWwuVZ0uR9ijEuHawU+nORJtTU+wpVWDYk2D3JKXoteiXyK
         Rpi6oUdlTOy9xtOc/AItMwgCPpEA7KRTXtLropfAVhfxjiBgGHz8vKPBqt3m41kW6PvJ
         v53agF0DK2+yoCJRIAS3qVfSlh7MK33F3skmludgz7HTToq9v9lCHmUd3tNrtMzO/LRZ
         vznWzFa4GRxq0Y+DjR0MexEZIFCcWW99Al37QsvdF2RSUjuatjj+usNdqtOT+SckQ6+r
         LTZATu/VWiqIfqHRX36/tHJfvbao/yD2QQ3l84B4HFgfZLEYXVo+tYLn5KN/Z02l7Ces
         M2qA==
X-Gm-Message-State: AOJu0YwMw9WO7hiQechnhq3tT2LM6TtinWiYx7pGpbCVdRy7y7j2YeCL
	aOwFdU7wYlDgHGd44bvcSOSjrxUgWJGU1BFBBDEZusZdVsMCkARJYo+DzHt/z97fKkn/hxwN/2i
	LzAy4yOo=
X-Gm-Gg: ASbGncuErFsYM4pFEXwucqE4/dSn6I8IiUCY5c2cgU/ApI5UR4IbAE5XLjMu0f5bxdB
	r+I8+zvwuzqQ84g4EMCfGB5svhWQwYZSPR3rn9quPgb9qFIT2rk/AOejY+xGmxkFMK6FyRpPO2N
	GQDp2YIQoecF53Ae7razsXbQ/AmCnU3PfyQeWcPDpWq2GtQgs3a5kNGhrh3NiYu6F91mUmWY2aA
	YIDJrABX78wbXzPcBEgpBe/VmEThVKGUDYRm4SQbZhUG913iOqw0Sg562f2fnY0dO4JN7exsMbA
	FXWAsU/ev2s4efDiV0IrHnX6OBNXLMSNe+Zewe073fa8kJqRV06Ygq6aieTmTYaBJk5jRdbbq/h
	DsyOYeA4H/H9C3/8AHhIiT98eCc6PlIKsnza9vFeRWNMsY6+uNfOa/GoXlflQHJM5G2N732cTCg
	AENreOqV0jlutQYxEhfi5Kgo0mr8IIcB8hqBkc3pM0
X-Google-Smtp-Source: AGHT+IFbFYwumuntbM0eAYNH4Q5R6Zy7pBwo8wpi7lm1VeaN1APZo7uFQHXiHS3g/+zoMWhjZgPNVw==
X-Received: by 2002:a2e:9087:0:b0:37b:af78:5901 with SMTP id 38308e7fff4ca-37cd9194d39mr7669621fa.6.1763757267365;
        Fri, 21 Nov 2025 12:34:27 -0800 (PST)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37cc6bbf1dbsm12940231fa.40.2025.11.21.12.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 12:34:27 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 2/3] Configure ruff code formater to preserve quote style
Date: Fri, 21 Nov 2025 21:33:49 +0100
Message-ID: <20251121203350.55855-2-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121203350.55855-1-piotr@qbee.io>
References: <20251121203350.55855-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 20:34:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2653

Current code uses a mix of single and double quotes, and that causes a
lot of code changes every time a file is formatted with ruff. This ruff
configuration gets us all the benfits of automated code formating
withough the downside of having to unify the whole code base in terms of
quote styling.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 ruff.toml | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 ruff.toml

diff --git a/ruff.toml b/ruff.toml
new file mode 100644
index 0000000..cfce94a
--- /dev/null
+++ b/ruff.toml
@@ -0,0 +1,2 @@
+[format]
+quote-style = "preserve"
\ No newline at end of file


Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B558C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:30 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.62813.1715612366145388189
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=PfSBbA1v;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.48, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59cdd185b9so943836666b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612364; x=1716217164; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxoeqR8W8B44TQWm3CgoMJL/I0+j814gzWP5IgIv1z4=;
        b=PfSBbA1vy7eP+Nhqgen0nipmtYeUvsVcQVu9mCtMLHPC72YDTS5eOfhlKjOKiI2RJm
         tmbYBmmy1cxNYbQETYYxXJImkmePoPfykoKBjw6A5fx+Bu+fEbtfLCbcdhUOItqF8qSF
         rWCwTlcxVqSsVjCIou+R49kdaeikKF65pBZufXuPtnNhuBLNfbNtDbDlNThJdBERVNct
         PRaIaVI49UvorljMyacCyhBrMlAv375rClHSrpoF6jjJyb/okFPsm+kM5Wmb+WAVEUd7
         OK5ZaP3YwdRzcBWVXbC9Fk2o5thpQbowRakf0XrBjHKLTFMwoxBUGSSBgmNxPeGwkB4K
         Yy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612364; x=1716217164;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxoeqR8W8B44TQWm3CgoMJL/I0+j814gzWP5IgIv1z4=;
        b=Q1ln+jFFr6dh5aOX+FBd6OAgHtlvywnTMIkQv8O4f8RLAwU7zt0s5/p+pGweLZZzxX
         bSnFFsr5du77p0QtFBmkf+JhaDfdDZbPasXYx5Zv7kQRKN3am3yieJew8zwkBUxLFefb
         wSmszk+0HkM8KskeWNRwVvm0xCUVETbVL4aJsAvIoF9hWLWu6sadBLknpa00P6btGopB
         c6ZfoFn7LERR34o8pXbShCc8rCmcK6VtlFqv3lIZ7VP8GWMoDXmdfUqqz/lcqqFFtKs8
         GFIMZ54itTt7v5os/U7FhHdBZV64xvMAPjwV+qNqhUGgiIgkmfCPhHAYAxZUAU+Nv21L
         MPbQ==
X-Gm-Message-State: AOJu0YyrQhUJrD3ehdzIatLIWN7Uc8iHWdaftjwxNL/k4nSBcnKREZeW
	hON36/KeHiiyMZdlfR+ESvZ4r2RZEEpWSMVhi+V/4b6S46n8I2YlNw2yLR2MQ/8H65J7YWn7AmE
	U
X-Google-Smtp-Source: AGHT+IH5TqEsiTwdw1CDAWPEBrsbsgKK1EthR6e8KFHnePTTnoxN0a1tZ0auhO09gDzm9udbILllUg==
X-Received: by 2002:a17:906:da8d:b0:a5a:7a1:5da3 with SMTP id a640c23a62f3a-a5a2d09e4b4mr989926266b.0.1715612363472;
        Mon, 13 May 2024 07:59:23 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:23 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 00/12] M12: Improve the Charts in the Metrics View
Date: Mon, 13 May 2024 16:58:49 +0200
Message-ID: <20240513145905.4167-1-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/120

Yocto produces large amounts of statistical data measuring many aspects of project health over long periods of time. Making these more accessible, searchable, and understandable directly contributes to the project’s long-term usefulness and usability, saving maintainers and other consumers time and effort, as well as enabling more and better insights into the data, which in turn leads to more informed actions. Better display of stats also better communicates the effect of Yocto’s efforts. The work will reduce the time maintainers allocate to administrative and analytical tasks, enabling them to focus on core work and bug resolution.

Technical Details:

- Improve the charts: Add descriptions to help users understand the data better, add dark theme styles for charts
- Improve UX: Unify styles with other platforms for an overall cohesive look.
- Improve typography, colours, accessibility, and styles
- Improve the developer documentation: add README.md with local setup instructions

The changes are also pushed to this branch here for review:
https://git.yoctoproject.org/yocto-metrics/log/?h=contrib/jacobabrandner/improve_chart_page

Alex Feyerke (12):
  patch-status: add .gitignore file
  patch-status: add README.md file
  index.html: clean up html and head sections
  index.html: Add general description to first section
  index.html: Add description to CVE trends section
  index.html: Add description to patch status metric pie chart
  index.html: add description to upstream status section
  index.html: Add description to recipe count section
  index.html: Move raw data to own section element
  index.html: add line numbers to CVE link lists
  index.html: Add dark mode to charts, improve chart layout
  index.html: linting and formatting

 .gitignore                                  |   4 +
 README                                      |  64 ++
 patch-status/index.html                     | 661 +++++++++++++-------
 patch-status/resources/apple-touch-icon.png | Bin 0 -> 7683 bytes
 patch-status/resources/dark.js              |  76 +++
 patch-status/resources/favicon-16x16.png    | Bin 0 -> 792 bytes
 patch-status/resources/favicon-32x32.png    | Bin 0 -> 1246 bytes
 7 files changed, 595 insertions(+), 210 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 README
 create mode 100644 patch-status/resources/apple-touch-icon.png
 create mode 100644 patch-status/resources/dark.js
 create mode 100644 patch-status/resources/favicon-16x16.png
 create mode 100644 patch-status/resources/favicon-32x32.png

-- 
2.44.0



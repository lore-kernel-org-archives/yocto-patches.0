Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E44C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.15788.1715182295280301752
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=pVZoPrmF;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.50, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b58fe083so793663166b.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182293; x=1715787093; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObcNDrTzfwyrD7LCkBqOLd2+bwLbJBCmEUyEaPUB8WY=;
        b=pVZoPrmFBFdgKWZ65gxbbxNUoto0LrEiFNVytatuAf5ZrVJQ3KwU8mIJajo6I0WgwS
         AIauNkuFMq0Ia39UdpEXFvLkmLXwcD7t4eJkgWk/ZgdajIJ+RwNyw35DFt5OlLw1HC4L
         cdwew8TN73N1z1Pc4GHV+4bArCX1M1Cl0b1Ad3WDM9RkWeP984m3+NvdmzHDWr8hHnfh
         VvIwzOrdXmFbkNkWQLXCYPrygkQ+fgZc4RJjf9uk0LoF+1QkD1CPVufJMy9g2IXZLLLe
         cxM5QM1yR+JwlCdTnzp8PKoGQ24ulFf+qRNouJgwyJL+hxAvCu6fX+yslCGJT5+E+B88
         YPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182293; x=1715787093;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObcNDrTzfwyrD7LCkBqOLd2+bwLbJBCmEUyEaPUB8WY=;
        b=pn846bprAyPmmyPfhHsfNZDjtIjrwbWTuSLFzT0xKWRXG/S9/t+XK2+kUQ/MIE9UwZ
         doe9g5Kp+QfbI+G9e4F7nrXD+YMRCJyLM/+k1IimN1whmVOh2iktw9TbC/v7i+GDiL1J
         R1Nh6ToT9K2MfjYhO0IHaMZfPOFirfTKlx5kHJ4kTCNRBTxjAYycTgg/H5SXvSVE96i8
         Ec4ZulirO4keqEH6ErEJNGvfmipns2qxyxYd2MbirP5Ow4rt6uZMeDw29RMCV41JG21n
         GnQ6qnMKAeQPT/kxB+Fo/JXcZfvFEkRJGerUVuLrV6m6uD+queF2Osk89XDc47x05H2y
         EcoQ==
X-Gm-Message-State: AOJu0YzWoaybLbz0CDemMlvH39LJrup/ImMqADRdBP5W2ADi6WtUt8XE
	x4lsSlwcaV3niqQUIcQJxdbPwEqLjQtQg5h8cODKgEGhUQa/DoHgYBm7kfTpcjQPOyXxfvcNVFR
	P
X-Google-Smtp-Source: AGHT+IHC/3zaOBmKRrPG4mIn23sh90YVOegYxi/ebNG6ZgMwWa4uJ8a2dof3DdtqSUEgAFEzsuEA/w==
X-Received: by 2002:a17:906:4ec1:b0:a52:6fcb:564a with SMTP id a640c23a62f3a-a59fb94b769mr170625066b.9.1715182293303;
        Wed, 08 May 2024 08:31:33 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:33 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 00/12] M12: Improve the Charts in the Metrics View
Date: Wed,  8 May 2024 17:31:15 +0200
Message-ID: <20240508153131.94270-1-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/91

From: Alex Feyerke <hello@alexfeyerke.com>

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
2.39.3 (Apple Git-145)



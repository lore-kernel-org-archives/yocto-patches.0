Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCEEC25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 14:53:47 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.590.1716476019105022083
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 07:53:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=XsvEGcZ5;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.208.42, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so11684088a12.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1716476017; x=1717080817; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4n/AeXrYhBTjrpjFYiRkEKPTDuZOa/uOXl+jt89O7DE=;
        b=XsvEGcZ5xCyGyYJxxz1GS4yCJwhTJMNsFfOw1mW3jIbf/Esdf+OtIupd01J0vpJgsz
         OwWbe9m/T9cahEmZpIZkcuBpRLqZ9gHRANDaztCyT+/dS84M+MIrTdni8ajo/7TG2FuO
         K5IHeXXniJooy+DZxRRl5S/RwvDKoPU5ansUm5KoqddLSRbrTkSFTVm/EA3XgF2juX3/
         zo+2fu2M3n5b89VIJVeUFt3XLKlGXxj7lWgrzSuC4wVN/RowH+INNPi2Mtt2dljNT+BQ
         quVB4dcKIizmJAMrR+JD5dKf8rYEjZn0b0zJS7C791dIkGtyLg/Exdvk1ptwSN5i5JcQ
         2JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476017; x=1717080817;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n/AeXrYhBTjrpjFYiRkEKPTDuZOa/uOXl+jt89O7DE=;
        b=sYlzD8rv+p3/1q0Ht09FPRA0QciE3ksS7VP8q/eZGiilk169lmFGUkx2s9xgMLTpE8
         2eZ0UQfnjMNiZ+bGbrXmy15OvyohsKKm1eeSjbW3W4nFSxqokx0N40Ih2qkTZF64CDk1
         a0nR9iTvxxM7W98jDdVc2D+UJaVU5khWNSNUILtptOMOxdROxtRa06m+k4rCAZ1MQuvf
         XANE4NpRvsjgoc4XSUcJt/ek6Br/H7977l9B/svswtLoiWQD8OOynG/C84qmgPQWmvm0
         iZ2nwhPVkw2L3kvs0gDQOoQQHoQwwKiMSUza7nRb+mS3JY/wiFEAVDevCwMJk5QzXDxA
         MhFQ==
X-Gm-Message-State: AOJu0YyGkwJJYSkEA1+8yqYQoe/NU+B7DiiqdmoIampC7k8MP4joEHGY
	TxSAdfpNTl4QwPl6qGRFeTd27ao5rV3naobWxksUin3CCboZCiAC1OiIls+mPEnAuk5J3Lvi4BR
	+t3k=
X-Google-Smtp-Source: AGHT+IHhXe4MZ1CEFWlfXNa8cBCqTRENdopGX8A2We2L40la3qbxsCt/3GNqFL5xEQelok1mJberEA==
X-Received: by 2002:a50:d715:0:b0:568:a30c:2db5 with SMTP id 4fb4d7f45d1cf-57832c4c74fmr2835075a12.40.1716476017232;
        Thu, 23 May 2024 07:53:37 -0700 (PDT)
Received: from localhost.localdomain ([62.72.77.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c06sm20394959a12.85.2024.05.23.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:53:37 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 0/1] Milestone 8: Index of autobuilder test results
Date: Thu, 23 May 2024 16:53:30 +0200
Message-ID: <20240523145331.49565-1-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 14:53:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/180

This work is done according to "Milestone 8: Index of autobuilder test results" as stated in the Scope of Work with Sovereign Tech Fund (STF) (https://www.sovereigntechfund.de/).
This patch file includes improvements to the Index of autobuilder test results table. The following updates were made:
- Added pico.css to make CSS improvements
- Added filters to the table for better readability of the test results. Filters were added for build type, branch and date
- Added pagination, which improved the performance of the website
- The html index template has been added as a separate file for better maintainability

Alba Herrerías (1):
  scripts/generate-testresult-index.py: index of autobuilder test
    results improvements

 scripts/generate-testresult-index.py | 103 +++----
 scripts/index-table.html             | 401 +++++++++++++++++++++++++++
 2 files changed, 439 insertions(+), 65 deletions(-)
 create mode 100644 scripts/index-table.html

--
2.44.0



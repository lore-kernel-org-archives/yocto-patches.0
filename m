Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A0CA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:13 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web10.61163.1755464891871953607
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=i7r9LCeH;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b121dc259cso15205531cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464891; x=1756069691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwGRPkUKMijeqfjIkOutdwrUybgdZG09U8j5rYwCVgI=;
        b=i7r9LCeHJBMv/wlzEVQXRfP1HT5+LSDrCbPvySFvNKqLF6l8dvJqiSax/FUWqdr7n3
         tiksgxS3hBrH6ZKSFUpB0cqZb541BXWtB8KCvawLPAWWh75ptJw2Sxctr+8JL1KwiPNo
         XRvh+VG148WuhkH+Vmby4Qn5WuIzTVvdsD4h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464891; x=1756069691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwGRPkUKMijeqfjIkOutdwrUybgdZG09U8j5rYwCVgI=;
        b=oMGxy/sTArlNRIpULuzYra4JaUY2qxD0A68TdLR3+gaQujtkkzQY7f6f4G0W1sdQ0H
         AURkFWP/hE0IoY3mGWamQsiMKVUSzybekqQ4vtRpQo9207FIm+Mu7T+57C0urrN2b5a2
         XppSpLs+WZl/4lQy+fhRcGt9fP3/Pbl3fiagI3POD2Ndh+mZw0xLOAhrvXbLXLBgYCqc
         6tpuiX/j5aKXA18NiIjC2pT/q7b8hkO/nGsaxhzT1b8bkMETJ46uHzqfXxANFtFPLQVu
         HmivqhysTDFh6N51E7QnzeZB2q1dVUrB/tmzQI+p3Lrc4jtMqmgu6ijs1BZ0ZTjXJHof
         VIgw==
X-Gm-Message-State: AOJu0Yy9EFG89xP49oL5ozsPZHhkW7jILZIPYxk2imWzZ6Y3iL2DgJpk
	xSFtLKV4V/DFgctUIWUzxT+7SuRWw8JCpwZVhkbAt4HdW6CwcV3dgBptXmpIek3ZzNzonDzkIJf
	X89Z+
X-Gm-Gg: ASbGncuWVqKNJo/tv9z3GV3baCGchKOhblEy9Qr0CNIrbhrtQcr8KEIUCa/MnSt4GRN
	5yctblX7ZzPBVcl/R1EfX9ZNH9S3SGWVmSz9543bJJOybWl6RGnW71VFavKNvvBiP3pldLBkv1+
	r34JaBx/AbrkHxGnLcwLxys77wBOKUNCseCC7DCrq/E6gsFqT/7DCvuTHvG771OdhEDB0lgrWS8
	13DW5wFPHLPIoHqKht+j31FxqFNhvarfspaLaLKnna1okXU/WY8gyGtiRYo4dW2q3sA0LyWf8gu
	tNaa/lzkoeghAwHce32Z8XIsLZluSUfXeNegx/2R/I+sQ/4GuE21XYnjCbZOtpUSszNfmLLvDQJ
	iSkkhaE6n9WAWii66NaNCU49f25GFnbxcZ1HJOm6Q9tq/G4FKPjkQmoqWOYmFlULBeNktoaSmo9
	HNud4ZjgsE
X-Google-Smtp-Source: AGHT+IEMr1Kt5WyNHLOjRfdqASwrPeQqIRBU/3uDUdLduS69sBH3mnGJgv7ag9+J9y/qbmIW3f3ZrQ==
X-Received: by 2002:a05:622a:4006:b0:4b0:6836:6efa with SMTP id d75a77b69052e-4b11e11aa51mr114494661cf.17.1755464890590;
        Sun, 17 Aug 2025 14:08:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 0/7] Assorted fixes
Date: Sun, 17 Aug 2025 17:07:52 -0400
Message-ID: <cover.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2023

A variety of fixes for enabling CI against the walnascar branch and fixing
outstanding build issues, plus a bump of scap-security-guide to its latest
version to match master brnach since the changes are minimal.

I intent to merge these to walnascar branch in the next day or so if there
are no objections.

Changes:

Anton Antonov (1):
  parsec-service: update PACKAGECONFIG options as lists of cargo build
    features

Marta Rybczynska (5):
  scap-security-guide: fix fetch
  CI: update build for new CI
  .gitlab-ci.yml: add logging of jobs to files
  gitlab-ci.yml: fix file redirection for qemux86 build logs
  checksecurity: update the debian package

Scott Murray (1):
  scap-security-guide: upgrade 0.1.76 -> 0.1.77

 .gitlab-ci.yml                                | 45 +++++++++++--------
 .../checksecurity/checksecurity_2.0.16.bb     |  7 ++-
 meta-parsec/README.md                         |  4 +-
 .../parsec-service/parsec-service_1.4.1.bb    | 15 +++----
 ....1.76.bb => scap-security-guide_0.1.77.bb} |  4 +-
 5 files changed, 39 insertions(+), 36 deletions(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} (95%)

-- 
2.39.5



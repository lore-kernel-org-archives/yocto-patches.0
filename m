Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B6CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:05 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.34460.1758141785056954548
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pBgWjy3y;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-811ab6189cfso24433385a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141783; x=1758746583; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPpgkGidOX6EWD3NoE2Awn9QGwTfX21V9MqshqJGWk4=;
        b=pBgWjy3yVpTFH2IoK/ZRl5z/+bUKie6HTXYJENjrluLJKx9cJM0swJwRm+yBOvgMgH
         2N3iK0eOLJ2HAbqymCzB1XaWpC8Lq8ly2zHBlhtLHPW7ajdQO6RylAm3JZrljHDZQyVB
         qHRYQt/44Ui4n+m9zu5GNWZY1NYCSLQTUxaEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141783; x=1758746583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPpgkGidOX6EWD3NoE2Awn9QGwTfX21V9MqshqJGWk4=;
        b=pMk8ecGEofN+XjP2ZYsYDvby9ZGI9OP+EC1C0EQihFQ57SgUmsg9lRXYqwQeeHbdmr
         ti1XzkgoeP86kkisQ7mq0LLBIqgsPrD4yx+zrqDRa5524pYKuJEl7z88K0cv9j3HN9pp
         JJF6M3NkQFuoixoBrNUb+rgqjXw0F33JkjYlF0ncQFZvXTLvD1DhlWEvvqvpx+DiSF47
         yWwxQVjLnrQgU2FNN+6TO/JWMMX2uMCt8rjyoz5qvENp5CMUYeHSNhtncKxPao61r6Cr
         8ocD7GbYvNAwhty9sQeRdwSIKz3tIQpVX/zdfMpvjvS9G92TkfyfeRz9UBebM8hiVZ7D
         goqA==
X-Gm-Message-State: AOJu0YxIqkYEJdf/3MtHtbF9pSG96HhGuQS+dtbHes/XqHyX+I6aEzKe
	TcLeCnnK+sfbkE8vZS8rsn1Prodfr8RMxW2fJDV8dzXMWBtOubn4Zz1ZRXkOHdTozSvCl5cvZ76
	HJpDH
X-Gm-Gg: ASbGncuuHHpJHJiwD+B+x723y4Y0Oawe7/Je4dAi/FfP3F06J2exzQ/MCWoLSWbfeMl
	c3EtD6IFwcpxPHwNhp7uQ+pgJMwEGQPGjmiYOtVVbJSOCf9bJ9cl4UTdrVtlV9M0L0dxzlXT1Hu
	NCotWN9sWQx0Eyhba7TybXnbdY95UGKlaNZegu+MPuTMsRKeQwO4leL64t4zETsDF7Ew+2vhba4
	egSZyt22/ik/WbM0kdNGr97g1kEKcoHMQoaA0jgQn0gCswtxyKNkyaX6pFsAJIosw0hWdw5hlWK
	CX7DhY4qOMMWgpyYVNMtAMtNwr4Sv4oVCtkD2KcGTNJDO9KT1rwb0opNa60RrRYe8cNNPrA3YId
	T33iCpmsXY5J4sgkACecYkE70B6CpnRfi6QJOhWi/dtBhPoQrvhOzOMtyObHrWlxvBrqkr0NkQQ
	==
X-Google-Smtp-Source: AGHT+IGrsPRny0TxCFtVnkvuoCKJnfsaA0G4GarZNSYTt650aG9ee0vntIaQbHqfIefv3J9AX0jZLQ==
X-Received: by 2002:a05:620a:298c:b0:817:528b:9ffb with SMTP id af79cd13be357-8310c4f0aa2mr375552185a.24.1758141783107;
        Wed, 17 Sep 2025 13:43:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:01 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 0/5] Assorted fixes
Date: Wed, 17 Sep 2025 16:42:47 -0400
Message-ID: <cover.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2207

This patch series rolls up contributed patches from the past few weeks.
I intend to merge these to master branch by end of day Thursday unless
there are any objections.

Scott


Changes:

Clayton Casciato (1):
  suricata: install classification, reference configs

J. S. (1):
  lib-perl: add a HOMEPAGE. Use CPAN_MIRROR

Michael Opdenacker (2):
  lynis: homepage update
  lynis: update to 3.1.5

Patrick Wicki (1):
  tpm2-tss-engine: remove libgcrypt dependency

 .../recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb     | 2 +-
 recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb}   | 4 ++--
 recipes-ids/suricata/suricata_7.0.0.bb                        | 2 ++
 recipes-perl/perl/lib-perl_0.63.bb                            | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)
 rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (91%)

-- 
2.50.1



Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B35BCD98D7
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:13 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2210.1763064844870269617
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Uc0vncxA;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed86157911so12764311cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064844; x=1763669644; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXdLch/5k4MtIjY9sK/a4/1PujdGBp0RvYhwQP0I/8g=;
        b=Uc0vncxAnLv01TEHrLycoADVqAFA8lZkON5B61+30znispj7X/rMtf5SbbbWe2Uglo
         l0B/frXCzd+CVQpkLaOVpobl/l/mNPQfwIZRlGRMu0PNLGkog6OdxZuGw75t5A7r8XX6
         qWXUu4uXiZWz981KokjhoHFHjCo/PNSQDayy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064844; x=1763669644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXdLch/5k4MtIjY9sK/a4/1PujdGBp0RvYhwQP0I/8g=;
        b=lAKzlw3+VR3p7q/3ip+seUmAInQ+rMhAGM5Whz0Uv+sIxrXnlT1YvaSGSdBQbW8U9L
         p/SH521jNjdRKf0qSiEKarmJbWC5sb29u2hZKxVLDUUdl+ec2JqoY5vdhi6Hbs0C9TXA
         SRQyKi6DDGRxiCYbK7hgFWXN/SRpzAjLl5oMJYsoxgCP6PP8IKQsg0gY8bF3PgSj999W
         1VT+ZByFSt8yxpHC7M1YdAwnbuNYbV7E1m3YcNZMG/n/cQEDYzZXK9L39EKXHIMksuyn
         Qt2jU+/R9y4pTQ8+ilroIivvqxbT8ihXmGvMAkCAETq4SrgyuP6u/H3YVz2AauvKrldG
         8qQw==
X-Gm-Message-State: AOJu0Yx8Nmzu5+orqXEOBa4evlGTtU6dHkLj/tcEfTcfKac858CJUE2A
	ekg5zbt1HCjJYU2lHB/mW9ccrqDbn0x4/18I2uBpXQUIN58naRUgMYWtpkO6gOugAOrWmPezPXN
	cFyr+
X-Gm-Gg: ASbGncvtSCEEdtl1Ox+Ipgyaj+s2gUzhTgpw6wRnemfuXOcaEikc2xEX0gqHRMCQ5y6
	VibAManFfozJUmPKKl5NXpGZxYppdlUja0Hko4gqSIthDgyeWSvrNvfmf3HayaTzfBEUnciJG5M
	cgCedCKInCTPLS38NtsH6OVZDKqw4s9vi2motw1RCudNmW5MXFNfQ7Mun8jsfOThZCjL4yZ/sAH
	0EWEoO2DYpTnHIvvjrq7bUHQTo5Dhty7aG1KcEobU5WDL8dOKKnHoU7JVySf3pp+peOUF9kWAEw
	zYIryYFv49SN61iwaaCRZYTW5OM2TgyheRvL6QMZmwv7T8IB7eXBGxTA+nJzFSDSH/XCjaO9Kha
	tcaiZ0ycBF1G+dWqqWPSjFGqj7o3K/g9kYBkXqYR4o2npnqWfjRSKJ0N/4An7u7TCUmDUaYAcWw
	tmWhFfM65F7Mw6pZDRn+uVDX8dVETcyTZnGnU0VbCIbXPW9niz+IW6
X-Google-Smtp-Source: AGHT+IHMd0HDD4+HL2EG289+39FYIFpeKGG8ZQ9Lx2xNRhOck7koLotf/iGB+k12rKburiQuEl89xA==
X-Received: by 2002:a05:622a:1647:b0:4ed:7074:423d with SMTP id d75a77b69052e-4edf20614bamr15873211cf.1.1763064843368;
        Thu, 13 Nov 2025 12:14:03 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:02 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/6] Assorted fixes
Date: Thu, 13 Nov 2025 15:13:36 -0500
Message-ID: <cover.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2544

This patch series rolls up contributed patches from the past few weeks,
as well as some other fixes.  They are queued on the master-next branch if
you would like to check them out to test yourself.  I intend to merge these
to master branch at end of day tomorrow unless there are objections.

For folks looking for scarthgap updates, I'm working up a series for that
next, hopefully will have it out early next week.

Scott


Changes:

Clayton Casciato (1):
  suricata: update to 7.0.12

Haixiao Yan (2):
  fail2ban: Adapt test output to Automake format for ptest compatibility
  fail2ban: replace fail2ban-python shebang with python3

Scott Murray (2):
  Update kas configuration for poky obsolescence
  ima-evm-utils: remove unnecessary FILESEXTRAPATHS tweak

hongxu (1):
  ecryptfs-utils: Add CVE tag for ecryptfs-utils-CVE-2016-6224.patch

 ...ao.unittest.TestRunner-for-ptest-out.patch |   43 +
 .../fail2ban/python3-fail2ban_git.bb          |   12 +-
 kas/kas-security-base.yml                     |   15 +-
 .../ima-evm-utils/ima-evm-utils_1.5.bb        |    2 -
 ...kefile-from-using-its-own-rust-steps.patch |   40 +
 .../suricata/files/CVE-2024-37151.patch       |   53 -
 .../suricata/files/CVE-2024-38534.patch       |   44 -
 .../suricata/files/CVE-2024-38535.patch       |   57 -
 .../suricata/files/CVE-2024-38535_pre.patch   |  292 ----
 .../suricata/files/CVE-2024-38536.patch       |   40 -
 recipes-ids/suricata/files/fixup.patch        |   32 -
 .../{libhtp_0.5.50.bb => libhtp_0.5.52.bb}    |    2 +-
 recipes-ids/suricata/suricata-crates.inc      | 1509 ++++++++---------
 .../{suricata_7.0.0.bb => suricata_7.0.12.bb} |    9 +-
 .../files/ecryptfs-utils-CVE-2016-6224.patch  |    1 +
 15 files changed, 847 insertions(+), 1304 deletions(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
 create mode 100644 recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-37151.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38534.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535_pre.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38536.patch
 delete mode 100644 recipes-ids/suricata/files/fixup.patch
 rename recipes-ids/suricata/{libhtp_0.5.50.bb => libhtp_0.5.52.bb} (90%)
 rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.12.bb} (95%)

-- 
2.51.0



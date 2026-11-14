Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6321.1794635543558768645
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 21:52:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=L35t/tAV;
 spf=pass (domain: gmail.com, ip: 209.85.215.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso871324a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794635543; x=1795240343; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8oOWLYZPNJ9nFaa2Gr/QxGhiXPppztgws4NEFpUfE7U=;
        b=L35t/tAVgJMlFD8eGgV264K+bJsMGHC9QrgdpGbrWUkqBMwl9XII1yKEdm6GGSGfpb
         v2BfNoJ6FRiiiJl/6kepmJ0+A+VlZSzv6BdyilzbdGPZ/ralSS0hD6LX6WK9qLvqa/qX
         x0q5BZBINn4i1JVB0sPV+5+T94yF76F/2qZcfG/Qnd0rm7+g3MCIMU95kYJR88FloKzv
         t/EZGcIoxvlqh1uokPUTqU68X+h+3PQWnsSFyRSTujq7TX2S9YD6y9Ff4zoQJQzZ7yeI
         DFeqNQP6e7oqCKKEXJLJ6bcZIcMfzSwfvB8u53pdYhmiCsiLQPYmpqJihVxZHRu0iMz5
         ldWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794635543; x=1795240343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oOWLYZPNJ9nFaa2Gr/QxGhiXPppztgws4NEFpUfE7U=;
        b=gqPEB+5zNZFe4hbVSDsP/nHfRaMXfpb+xc+0nnm4W6AoL7avt26IencUmVqAshN5/p
         T0rLSKH2C7s/+lKg4i0O1VfFYkJE3ac326ZTrilziyLH35GIGWyErQ3aDmIy4ex+OnTf
         fEdCPW4KRUIppkGGETWgDRalRWyfHgvMw2Slx7LPeyYH5kNICnS5mUyd4i/PRh463dmp
         Zxf02U1wI3Y7zmodqm9OZli95UhkBPzOsOYuwDiurRhQZEtuv0Gy1B0klLrDtHrYMj+i
         HQpsESvjnn+mHdB2Snho7DOVaox/0rIjjn1scZ9AgqDsac73FoyKUUBkiZWvHTsoTCp/
         SOnw==
X-Gm-Message-State: APuU4Z8FEEoDJTqVO4ycN6gq3/68cJXY7K+gyMFjilpq9v77dKrGPBJu
	LBG5ggHLqDXhjGBWcaDx8FDDKTSZhrIO39TjKLMleSHLrTemjS+oXmy4pwkcSlZo
X-Gm-Gg: AYBFou0Yt0aQ68+Dxzr2kcEWcA7bAlCNbyx4NdZgmtgT9lPjcERDpgDW+Vao8AariqY
	qZiMmqHAm/KRlTaahcVoeuOOVLjIHInQ1fNVW73jVyR6h+QpYrklC49jpTkdOHPOLWdN/NCm1/1
	KBUVD8qw/9sZvHU+UUgd/fhdmeFAsKgK6nupZ9Qnsl0cGIPkdaFIjqBcMXE4Pebyh3RlwRseX88
	nZ44pRt0Vytafqf+iY4ghJqInKDJoFAmhl7Le2KZRpFAGu46ldGDcJzU4egO8w4sK20hLuZ3rkr
	XFgASm5O3n39P9SWYzTO3GbVcGpwk/Z2FW4A+F/AmEjxd2zHMCE0hC94q00CM8rSo8zYrtULIdJ
	lWF65DTKCi2oQdAz3flPF6TfhlGQwGT/YumVvsWeIhwt9WaZStQfxGmOkPi/FCzPTALYs2BXW52
	Wpi2wTfuF235deBr2L3nnb7e+LuJFTW3KuSFy4JvdC7Eh/WWryoypIjWrRntyBz3XfDZLqsSrVl
	FTs4lwq/mhaiD6wpd4JIHYUGGCaQdfeGYnxql9ygNeZcD1YMAPzQrCXf0KVGkEFz8o7V9GDu/uG
	VOF36lkSRyk2EPaFwYlBgSxHPbzw8aQYlgA5GMI6nuyeJssgJjhDaMH9Zx8UFw==
X-Received: by 2002:a05:6a20:9381:b0:3e1:a4ac:2d5b with SMTP id adf61e73a8af0-3f7a7aca9d8mr4091310637.41.1794635542477;
        Fri, 13 Nov 2026 21:52:22 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2635285sm1957746b3a.44.2026.11.13.21.52.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 21:52:21 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/2] Let maintainers change their email address safely
Date: Fri, 13 Nov 2026 21:52:14 -0800
Message-ID: <20261114055216.2636-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 05:52:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5369
Content-Type: text/plain; charset="utf-8"

Bug 11195: a maintainer who changes the email address on their profile
loses access to their layers, because edit rights come from matching
the user's address against the layers' maintainer records.

Moving the maintainer records to the new address moves edit rights, so
this is done carefully. Changing the email already logs the user out
and needs the new address to be confirmed. On top of that:
- changing the email now needs the current password, so a logged-in
  session alone is not enough, and the old address is told about it;
- the maintainer records only move after an admin approves it, with the
  "Approve moving maintainer records" action on the user's profile; the
  admins are emailed when a confirmed change is waiting.
Users who don't maintain layers are not held up.

1: The profile page had no login check, so a visitor who was not
   logged in got an Internal Server Error instead of the login page.
2: The maintainer email change itself (bug 11195). It adds migration
   0057, so it applies on top of "[PATCH 0/2] Remove dependencies
   dropped from conf/layer.conf" (bug 14348), which adds 0056.

The test suite passes in the Docker image at each patch (83 passed,
1 skipped at the end); the tests go through the profile form, the
activation link and the admin action.

Tim Orling (2):
  layerindex/views: require login for the profile page
  layerindex: let a maintainer keep their layers when they change email

 layerindex/admin.py                           | 26 ++++-
 layerindex/forms.py                           |  8 ++
 .../0057_userprofile_previous_email.py        | 16 ++++
 layerindex/models.py                          | 20 ++++
 layerindex/views.py                           | 45 ++++++++-
 tests/test_profile_email.py                   | 94 +++++++++++++++++--
 6 files changed, 200 insertions(+), 9 deletions(-)
 create mode 100644 layerindex/migrations/0057_userprofile_previous_email.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 6c677e4190187d389840d2a94b4d857a69c0d647
prerequisite-patch-id: 282bc018dfe6528deb8363d3cbd1b31671c4b606
-- 
2.56.0


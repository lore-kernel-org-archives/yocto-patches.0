Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD36CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:05:26 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8058.1792289125323707037
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XjF6Y0Pb;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso580896a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289124; x=1792893924; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bjv4qKJLaIqbwEdaDS/A0h1ofCh4Y9Z1JVQRwr0pnDo=;
        b=XjF6Y0Pbdgd/eR66LSb1EJSzyEhGvDP2u3qFFmHIsLR0KD8GkxCnXJUSo7SBYyoJd1
         VSh+XYDlVB5IKZnZKwlhIBaYgfvU2WLhOQC76j9116CraYFyZEv35XSWzIo7fh+faZB+
         graIjbViOBeMv8p5qHJ5AwJx3+0KW0LzZjDxtDIaPreqGDgAoZmqw01TDvA4cYwuStFF
         PcG3PwqXUyj/vwicIi70zVjtg6Tri/vpbN8FXcMm7h+fe653zLgdJwgUQjwUbglo3tsQ
         Bln/b9zcHT/d7AqeWEo/PSQ9IOmXQY9IuPZmKBzvYcw8DL9uP2O0rXpdGDn39QY2GWYo
         CgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289124; x=1792893924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bjv4qKJLaIqbwEdaDS/A0h1ofCh4Y9Z1JVQRwr0pnDo=;
        b=ieDBBVvxUpKHmWIgV5vV4myQ3b1noxL+fPD4ACrZKwYXxcrO3hNgNbiYFPB8T5Ivwh
         CoJ5mudWcVq2BZWrJUqcEQHloVCRS16BmE2fUncY/t67S1+wDZlrdH3V7wIoK8Sh4XwF
         vIaBmKlZcmL0JGNfzHq9PbnqDk9Cg1KZSsNGy13wqaIcsRe4mJuR3xHz8oxL+r25yjGW
         YTA95syFT/G1glAKim8gB5PSq0Gy4vpEuWWcHqYVZ5/EEMckpy+wiMH9AdCDhqaLjR4V
         GMiE2GIoFNMguIVNMQPVYkf68zi/uVUbA5aGTKfFmXxsYVu2mAMquCVFscfLETDL6czY
         ZyBg==
X-Gm-Message-State: AFq9FYI1ZFXZd73f7oTO66D8zqVUlwpO1u48Pd6uqFHXHU6zL10cdObb
	/rZ8QpLiiNpyJO5EqpW1rwRse6saADkjROUre/mPggs1auRBMTOh9OviwINBleMJ
X-Gm-Gg: AYBFou12wpSqkf5ci+a+Yfmb7UcrxNS3yP/hMtDOHW7cgArs8ZIzF29W1G9TMUljdRP
	XgtJroW+su4adE5hN+ozX+Hqpp7PO01YO94xTARkTWU+k9mcgvvDMfUqdf2m3wkOJy9C90M0veM
	YyhrnrXEdKcLslSzttMQ/koFLPh1YYkH2aH8+8Uzf5wFiuMwOdB4lykMu5fPzFpKGFNTYCyC09/
	3KnE4CacbPbNzl7SSxioG4O3rEV0+R6O7+C2uI1lwvIqHoD77EVoltQ6rj6a1fCb59oGsEGRxHc
	VTyx4y0nfpVCJUFY6YyNe7pyBrNY9at9qzu1erpQwztU2/h6PE07KrN5jYtIACo86mSLFMKMBbp
	rO6mQuW3LN1beFPy4ml/Fq9V0hTlozW/lAzlL9s1c0zIz5BSG8uG5kFdD/4KmGD4Si1U8yfvIgr
	PhlPWF6WcE9rk/3daLclk43Rauqt+SEdyzg7IYPxj071/CvEfKpyuwSYHNA+lwYK9MRHP2JZ7E4
	xtcXyYJYprK+zgXkpbCYFVeLtvLgfKDWNrBFPDqEA==
X-Received: by 2002:a17:90b:440c:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3acef5388femr3560067a91.49.1792289124555;
        Sat, 17 Oct 2026 19:05:24 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm5775584a91.0.2026.10.17.19.05.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:05:22 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/2] Don't render submitted data as HTML
Date: Sat, 17 Oct 2026 19:03:52 -0700
Message-ID: <20261018020518.76802-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:05:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5066

Fix some security loopholes in the old Bootstrap implementation
and remove deprecated/unsupported bleach.

Tim Orling (2):
  Don't let Bootstrap insert submitted data as HTML.
  Remove bleach and store submitted data as sent.

 Post/parser.py               | 10 --------
 Post/static/js/main.js       | 14 ++++++++---
 Post/test.py                 | 45 ++++++++++++++++++++++++++++++++++++
 requirements.txt             |  1 -
 templates/latest-errors.html |  7 +-----
 5 files changed, 57 insertions(+), 20 deletions(-)


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
prerequisite-patch-id: 9c9d012e1163dd1d335531d0451657823f17eb64
prerequisite-patch-id: ddb4df3e54736ed25846f91d4918299e601f4071
prerequisite-patch-id: ab69f4aa494291611cbe0e916f18b07f4aeebe57
prerequisite-patch-id: ac2b802ea065536df3854c48e265f5508d201cff
prerequisite-patch-id: 81a7de0e9568848efc8c66d397abb5f56218db95
prerequisite-patch-id: cf32dcaef20903890a020211a35f46b2384207da
prerequisite-patch-id: 6920bc5c70071bbd42b55b08bfc2bff04133c3ab
prerequisite-patch-id: a72bee4356db80ccb45321967d18081961f60860
prerequisite-patch-id: a2285b682329ba20d838085588b7c6681a86d273
prerequisite-patch-id: c3980e46d49b00b419cf4a7c2bc32c346478a453
prerequisite-patch-id: 627f58daa68852066f56558f08b07ad4af7bef9f
prerequisite-patch-id: 2d1b78495c909de035dbed74af06db5683701d1b
prerequisite-patch-id: 028165edb39ba03ad70f83ae9e2f36dff8c7e912
prerequisite-patch-id: f882f3967c3decfef434c86f2bb019b228275bac
prerequisite-patch-id: 6d9b0b9eba49c93ca0bcaf6cd25bc079efccb7cd
prerequisite-patch-id: 460c40f8c35ebd0f31d5d52f06c32cd7c1232fb7
prerequisite-patch-id: c7d6ab550cb907d3cc7e3a3b777695f45649c46f
-- 
2.56.0



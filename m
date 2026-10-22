Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14855.1792636479309595753
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 19:34:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qj5rQxzP;
 spf=pass (domain: konsulko.com, ip: 209.85.221.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b060ec084so1031835f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 19:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1792636477; x=1793241277; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NS4y9ex+WP59ssxSV+StQ4hQOJmidmvk9154ZSiiw1Y=;
        b=qj5rQxzPM8qjrQU2jC8D77x4ZIYH8gafhiXg+e829zuqbAGxze7ruE+9JULVhwp88u
         hf1OlEhgO8BcIAy8IshZFHaKgHAlYuxNruZlv1kbpFKOq8K9qeCXq0bDMambgWN9BUbP
         XwxGWoGhtDtU/g/WO4ef1LDDqnokqUEM03+VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636477; x=1793241277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NS4y9ex+WP59ssxSV+StQ4hQOJmidmvk9154ZSiiw1Y=;
        b=j8rpuWE3WfH8aRr5Kmy7rlHYNO9LNchiIbSwzgSNChMhEgvi/kGO3QpCG1TvakPJWS
         kfFRhbMN/Iehu1IHNDsssFfm2cKHqw3UkbIsjJlHdoJqjCjHhfeBhUG9srYD0Zpkgs38
         n2eBTiNL6Dclaf3dScQ1xolUMsqd81WvL3XeiDJ/UytoAxCvg6YGgS3Na3xxRRq5rM1I
         tQn5cq0r2DkaU7cEyB4mYhXbZSKqnzxHDaOiR3JlmkXD3XHQCz6eb2M8hLXvSfHsvhUf
         Z6s9wSfepAgVpLmF7h+T4QMwcjqpRIG1TsD3RNsan84Ve5495y93ddtle4LJmLIU9lhw
         yO8Q==
X-Gm-Message-State: AFq9FYJ6uat1eMftGqyGvMKxE+Stzc52vy/U98Txvt2PRg6JwEnUd/Dd
	kGsD50LmHqV8dUPT01c1c1qU1lZ3wsX31AxTENdjx5nC/divdbIBhX27QqjoTTg/AI0jnUCI9eX
	Hek1U
X-Gm-Gg: AYBFou28UkMW5cs+2iaZTaXsKLHrQPXXtbgiswLXYgF1whAbX45x+lfzaSQkeyBmfm6
	d4+Ks3nXXeScsUfz7YpCOUHXs8y1pHorQuXxDrEcJJdwT1jjqW1zIbQregIZ8P0yDvigt4e4xEs
	RLHaA46zX6ISVeX2RGZsXzIJjpYFz+vpxUscYzjA5unFOZTv8/LWXA6nrUZQN3r4GxOzmmpraxl
	YBT8guYG0CckCQLdulMBEB1s0wNvdQB6kV3cgxd2OjF2z+aEClLTSiCrOtXX1i1mVPgpYVZihoM
	50E5WjraC8BU8TPjEEBktI2Fl9etMfUvy/6WfDN8lRSbxQd72RKkbx8mn1gZAONHbO1viYXrKPN
	yoSa4IqMXYLVpC62Z98z26ekxcFnf8g5bKfkjL/uQfgkkkxTHPHSO5CeZWmpN5BJcAk4DlKYXHG
	8tRE43EAG01mDM8TuJfgokMKKBOPpNbtUcAkdYthD8FdIK8eCgnvHmZN/Vb4H80WDi8moNebsxm
	6itqrslWSgLfkjbAJzwyrIMn6ZspPDbNSdfvno9Ctc2QgCdfBOnxiqqtO0G79hVXrt5GmYehRtJ
	GY/KUIwcqTksnBFEVQZvzK1jRF/JL/qOYUbW4ves6mebh+DUt5tUQH7u
X-Received: by 2002:a05:6000:4549:b0:48e:1b11:7ed0 with SMTP id ffacd0b85a97d-48e264b2c07mr5572102f8f.33.1792636477091;
        Wed, 21 Oct 2026 19:34:37 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583e25asm9591423f8f.46.2026.10.21.19.34.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:34:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security] master updates (cover letter only)
Date: Thu, 22 Oct 2026 05:34:21 +0300
Message-ID: <cover.1792636192.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 02:34:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5128
Content-Type: text/plain; charset="utf-8"

I've been quite busy since getting back from OSS Europe, so these were
fixes for master branch got a bit delayed.  Since they passed CI and are
for the most part innocuous, I've gone ahead and merged them to unblock
folks ASAP.  I should have the blacksail branch set up in the next day
or two, I just need to rebase a few changes and get it through a CI run.

Scott

Changes:

Scott Murray (3):
  meta-parsec: prune LAYERSERIES_COMPAT
  glome: update branch name
  PYPI_PACKAGE fixes

 .../recipes-devtools/python/python3-json2html_1.3.0.bb          | 2 --
 .../recipes-devtools/python/python3-xmldiff_2.7.0.bb            | 2 --
 .../recipes-devtools/python/python3-yamlpath_3.8.2.bb           | 2 --
 .../recipes-security/python/python3-oauth2client_4.1.3.bb       | 1 -
 meta-parsec/conf/layer.conf                                     | 2 +-
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb    | 2 +-
 recipes-security/glome/glome_git.bb                             | 2 +-
 7 files changed, 3 insertions(+), 10 deletions(-)

-- 
2.47.3


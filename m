Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6134.1794870251266074481
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:04:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=e4athtpL;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b2382bf051so2248202b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794870250; x=1795475050; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1V2GsXAOXqm+WSdR3+98nfbE1OYGWssLc1nvZ+un5w=;
        b=e4athtpLpf+aMRSRE4tCAjQIY61gipOxwhjbJvitDzdTLjDuKjHbmCfEwn7L2Mug6g
         DhZW0WMr8o9B9dMri3naDro6hu5owI1qG7+7fxgJNptjQIqzjY7/XoYl6wZgV1S73zJU
         aFDHlGokezXbAVj/9rWLywxoczOLWc1XdWAAa9fMYlvUChNp3QdcHFEo0ZuLxRqpJita
         S/xgp6uBk1aaSAKueS0+K7Enf0wGC6khyzGnNYLaLfQwW/G3/oVdKmnGiQ8m2u7N5p84
         5ciQix6wZbtI7MYM2C2RzuJDZ8QtBQct/LccDTMLglXOu2fl9ayTVXSt6/Y8xngzpea7
         STnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870250; x=1795475050;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1V2GsXAOXqm+WSdR3+98nfbE1OYGWssLc1nvZ+un5w=;
        b=LoyM1pB4uXDZ8uv7l8L1rqZGstNnNXomjXTYaSmsUHfxgiktRGkjYDfisUuT1jYU7/
         pinpW480OCUYkCR/5H+ACKXsK71B9G1y/HOhVSYabQNYxuVoK4KGyxOrbqhSt2vNyXbY
         OR9qh1dUsY4dxwk7q+t3iXEOfU//M0oU6Ttp6yrFRYeTleVeU34X3SrSgSRVqdDkdQTQ
         14hyW+slsrdo8Fw78R9gt/WchEcEiG6oDFPt+N2wIs9pFjLhqUfkJLurhmKQR4Kv0EO6
         0005m1l/JyXF8UQXZUKTjYdiD++7TJFsZXpZxtkDfUYMTJjuw5SXElyKDhYdogTI9txa
         JCXQ==
X-Gm-Message-State: APuU4Z/mcb+GIc1xHFQds1z1+DqIjAdrVjKCsiUSDerxtKekhDnd2xo+
	WogPAXQ+T8Jvd9kmsQM8nJn+1byfyvX6sB+o0Q+l05m6Fe8qKj0QJGFgAV5jCg==
X-Gm-Gg: AYBFou0q8hVlad6pd/yfG1IDDLC+qc8FH6D2s1MC+E6qVWyOuel7O79c46FsCh1JAaM
	jet/hFOzq9jR2xEs4DazI9/KZ1E9ZpkOsh4dprKTiIPy+ptUHaZCnKO6BpK1S7BQAt2uyZyAUtD
	Kscwsdh/ZmK0m/BRjsqkz9NvMDUf7XsR9NYXrQMuOzDL36mRysFlOiqrhl3IQvRTozA22y0q/vs
	+a0wNQS6jSjCciTrkWYPqmQ0qnD4QvPoFOQosEqojf96mfCySLCJY5HzW8K71K1edbpk6A1OS26
	2E+kz1db24OKZzVR98uaoFkKAYzdPA5CDzBBu6vphXU+l6znAMysBt5Y0kPjgbJXBkwtOTBYHwX
	E7JO6+6CS8+4PdZ3WJMd4lrxIm3Zm01xixEJw60gLyRpxNCpTf3J6DAo9m5jjIt0FuRbefjT5HM
	pju8NpKsA8+7/+VkoEtzMGujJhe9bUdnstSVIPOo8n20C8EREIAv5huJqz3uq9MHeBeO9DmAVVB
	h9KIOmjYMU9rYMgkir5u9WNDDHltFdyn2/VFZdQfu1CgV+lkVMsb33GMN7KZ93VpqMMsuyGA8pj
	c9sIawXtTs60DCD6L67NZsXkzyZ9HcItAFkJ399cmbQd0dUkPdTDvAc78h2NZw==
X-Received: by 2002:a05:6a00:1990:b0:8a0:6905:248 with SMTP id d2e1a72fcca58-8beb374dcdfmr10742382b3a.3.1794870250356;
        Mon, 16 Nov 2026 15:04:10 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a90f1sm4210535b3a.19.2026.11.16.15.04.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 15:04:09 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Return 400 or 404 instead of server errors for bad URLs
Date: Mon, 16 Nov 2026 15:03:48 -0800
Message-ID: <20261116230401.42917-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:04:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5434
Content-Type: text/plain; charset="utf-8"

Fuzzing the URLs of a test instance loaded with a copy of the production
database found about 160 requests per pass that gave a 500 and about 350
that gave a 502, from a handful of causes. These fix four of them.

1: Bug 16517: an unknown field in an API "filter" or "orderby" raised a
   bare BaseException, which killed the worker; a value of the wrong
   type, such as filter=id:abc, raised ValueError. Both are now a 400.
   In Piotr Buliński's analysis of the production access logs from July
   to November, 909 of the 912 API server errors were malformed filters.
2: Bug 16518: the API never applied "orderby" at all.
3: Bug 16519: a non-numeric id in a URL, or in branch_comparison's
   from_branch and to_branch, gave a 500; it is now a 404.
4: Bug 16520: a NUL character in the URL gave a 500 on PostgreSQL. It is
   now a 400 on every database.

With these, the fuzz runs give no 500s on PostgreSQL and one on MariaDB,
the 4-byte emoji case of bug 16507, which these don't address. The 502s
that remain are 5000-character URLs, which uWSGI rejects with its default
4 KB buffer; gunicorn returns a 400 for them.

Each fix comes with tests that fail without it. This applies on
master-next, where "layerindex: add an RSS feed of recently published
layers" changed the neighbouring line of layerindex/urls.py.

Tim Orling (4):
  layerindex/querysethelper.py: reject an invalid API filter or orderby
    with a 400
  layerindex/querysethelper.py: apply the API "orderby" parameter
  layerindex: give a 404 for a non-numeric id in a URL
  layerindex/middleware.py: reject NUL characters in the URL with a 400

 docker/settings.py            |  1 +
 layerindex/middleware.py      | 21 +++++++++++-
 layerindex/querysethelper.py  | 41 +++++++++++++++++++----
 layerindex/urls.py            | 18 +++++-----
 layerindex/views.py           | 32 +++++++++---------
 settings.py                   |  1 +
 tests/test_nonnumeric_ids.py  | 51 ++++++++++++++++++++++++++++
 tests/test_null_characters.py | 45 +++++++++++++++++++++++++
 tests/test_restapi.py         | 62 +++++++++++++++++++++++++++++++++++
 9 files changed, 240 insertions(+), 32 deletions(-)
 create mode 100644 tests/test_nonnumeric_ids.py
 create mode 100644 tests/test_null_characters.py

-- 
2.56.1


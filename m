Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5211.1794867861213462751
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:24:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=zaJpgEze;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed11653a91so22226705ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794867860; x=1795472660; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BSN7f3TAT3t1/zGb/PbJo1KeStQRvi/w99tLIPk4PE0=;
        b=zaJpgEzeJfLTvW2gC7lS8LNwmVot0SDRVBfNBZsUIWdhcAg5lhgNMSwiY3ttosH+05
         aG9PuFhnd31Vlvm0VJ4x4i6DxZ7PT/wHQxlHbdLzg+auizK7FwISeZjmS2xxF+suOBmh
         Nuk7wKoF0ehfzL4OvR+BEY5wvrQlhlXhrnSBOPBBIZExCI3lKYPeTSw3A38jHipbq1BO
         kcwsFhujzvnytdaJwVUSQIp2UVDUwcaI5MNodwbesj5ZfzMlA9JobCxKxegD6jdqR7M1
         48P+mEYdLzi+dmDpTsBlLAgd3JZc2lfV86FAYCrfa+jTjE8wk1gOIN/oonG1VEaM2E81
         ubLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867860; x=1795472660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BSN7f3TAT3t1/zGb/PbJo1KeStQRvi/w99tLIPk4PE0=;
        b=vGXsWfGKy0d+dcczpmnuwLPfLWZkhSeyAiy1HzfJ4eh+IWNLH15VEq1xoKv6RVv72X
         a42j+1EfxQiuRTeelYQrct8NWRdROAbcJQUWNLipIukv5xVz+3L4VKXMYqeVh3EjLes2
         9l6TCAGY2eIa1SiTkdlVRZXpjf6E3e1KREaG9VSkqPSVsddhHKfRoQCRKAbGcSAratnb
         fw7yKDfRCj0iSnsZqTdV/R9u7edtVHw1UUoy7ODQBp1b6PAh9DgmLeji6GvFXZK4x+DH
         1QTzPFOdzzjdmajeGU7N52pqdT3SxKv5n6onamXwl2AopVuY+1g+MwlOv+SsVFm5KBWV
         II4A==
X-Gm-Message-State: APuU4Z9VrNS9F816J8d75J3pYd89xfH76Mm4CNZLKS1rve9h8vd77Bh4
	Nv9iqvoVE3YoCuEhrvlLyF8trcDnD03qGVQO+/DThSEps8oBSG0LsxXVgGJw7A==
X-Gm-Gg: AZFdTZd4/YQoRNXSo1pv740M3S0L5Vw5gSPvkMVxe+puNZea3AbsGXOebN62Mb3VuY9
	X1U0NHHv7CLAyg0pKOnP9vt0+n+JPB0Zh6QjCgvZYBRqvasNQ2ZEeHvzbZWizgEePnFp4Ht4L/m
	c3KbmMJLimUr9B8JnQ0uJ8YbtxeNN+91xP0WbWwZ13cndbuR5eg3I7dsVj7ws1rUYK9FNuDo55d
	/9pZLrNxymiip8ilYK8LyiiRh+mujybpFA9wb16V++TS1NqAOI8P4LL6MkzoIxKS/csWmKqTGe5
	Ksm6H+6bWJNBoo6aLlbV3LL3uPhqjULYMcdERjYN/yvIwMzgyQ6Wd99b0U+2uuTJMiU0t7xTurp
	KcXZ8vV5CsXqYaSCxZlXZAdL9FwwF6cibqPu5UUNCW81WC0C7tFyhNunmOWl1sQl37sJNFj12UK
	iuJkhonvUiPmGjGyS1wH/CQjYpYJGsv5Y6+5DfZshHbBl+0zYNFV0k+DwL3O5H43aI0X5UfG1tV
	U7MmQKKNB5pElNuQPAVT+nAOeAoayY2NqexhDubDPU7rU7AJDaXD/XbYzh7GcE53GoiTS+euYMu
	0r/YtwnqFcJmwsVEXjv7ZJ4JJlq7kYKfMWL2JCiS0nQNNXY0J57oWh78iWy4cQ==
X-Received: by 2002:a17:903:41c4:b0:2ed:cab:e977 with SMTP id d9443c01a7336-2ee0da966e7mr129776945ad.12.1794867860379;
        Mon, 16 Nov 2026 14:24:20 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7ab4abcsm4618945ad.70.2026.11.16.14.24.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 14:24:19 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Speed up the RRS pages, and test them
Date: Mon, 16 Nov 2026 14:24:06 -0800
Message-ID: <20261116222410.35784-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:24:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5429
Content-Type: text/plain; charset="utf-8"

The RRS recipe list, report, maintainers and recipe detail pages ran
queries per recipe, maintainer or upgrade: about 5,000 for the OE-Core
recipe list, which took 4 s, and over 2,500 for linux-yocto's detail
page. The database itself was busy for under 0.5 s of that, and the
lookups already use indexes, so these batch the queries instead.

1: RRS views had no tests, because the test database is built without
   the app. Add tests/rrs/, run by docker/run-tests.sh in a second pass
   with ENABLE_RRS=1 and --nomigrations (the RRS data migrations need the
   core layer first), plus a check for model changes without a
   migration. RRS stays optional: without it tests/rrs/ isn't collected.
2-4: Batch the queries of the recipe list and report, the maintainers
   page and the recipe detail page. Each comes with tests of the page
   data and of the query count, which fail without the change.

On a copy of the production database on a test bench instance, the page
data before and after is identical for 12 recipe list milestones, 9
maintainers pages and 153 recipe detail pages:

  Page (OE-Core 6.2)             Before    After
  recipes/                       4.3 s     0.32 s
  recipesreport/                 3.7 s     0.12 s
  maintainers/                   1.17 s    0.17 s
  recipedetail/ (linux-yocto)    3.7 s     0.30 s

Building the meta-openembedded recipe list goes from 9 s to 0.3 s.

This applies on master-next: patch 1 changes the lines of
docker/run-tests.sh that "requirements-dev.txt: pin the development and
test tools" changed:
https://lore.kernel.org/all/20261114070852.41000-1-piotr@qbee.io/

Tim Orling (4):
  docker/run-tests.sh: run tests for the RRS app with RRS enabled
  rrs/views.py: fetch the recipe list's patch counts in a few queries
  rrs/views.py: fetch the maintainers page's statistics in a few queries
  rrs/views.py: fetch the recipe detail page's upgrades in a few queries

 README.devel.md                 |   9 ++
 docker/run-tests.sh             |   9 +-
 rrs/views.py                    | 171 +++++++++++++++++++++++++++-----
 tests/rrs/conftest.py           |  52 ++++++++++
 tests/rrs/test_maintainers.py   |  94 ++++++++++++++++++
 tests/rrs/test_recipe_detail.py |  84 ++++++++++++++++
 tests/rrs/test_recipe_list.py   |  71 +++++++++++++
 tests/rrs/test_views.py         |  52 ++++++++++
 8 files changed, 514 insertions(+), 28 deletions(-)
 create mode 100644 tests/rrs/conftest.py
 create mode 100644 tests/rrs/test_maintainers.py
 create mode 100644 tests/rrs/test_recipe_detail.py
 create mode 100644 tests/rrs/test_recipe_list.py
 create mode 100644 tests/rrs/test_views.py

-- 
2.56.1


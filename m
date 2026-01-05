Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405BBCD0423
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 22:52:54 +0000 (UTC)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.77736.1767653565062860121
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 14:52:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Iqs4EVrU;
 spf=pass (domain: gmail.com, ip: 209.85.218.65, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b7eff205947so63287566b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767653563; x=1768258363; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHiImJD8N2UvwzrgD0iQU7noL9zXKzvQqCdqH7l+cuo=;
        b=Iqs4EVrU3treLfu4irA+0JFqjcAInAFVCr8QIzP1Be+WIXlSV2OjzBnxPKRdBibjwq
         cfYWuHqTgDTKmWwXKbXZYGoHV7Lorx9wAj0wiaVKT2CKcDCOYlDkgHzLiz7yPCh/Fm4i
         vv8oMWvYNi/aTsPa4WLp93XBBA7RTQd/uBr53f7et1sDQAiNRNFNxcWzYAbzDgtonNVy
         ZRKW2AGitHshYqZ27+BMp25wh05xHEAct+1YceDJA5r/6DJDmEeS6OO+aREePhucuZ1I
         UJUdPZq/37NQu9MPF3b9Ofya2rAvijZoWiv3wLN4Ud/59DaEo0381t1SHge7gogz8yAY
         x5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767653563; x=1768258363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHiImJD8N2UvwzrgD0iQU7noL9zXKzvQqCdqH7l+cuo=;
        b=NFxMgM2l2F8l/sXxnUnWm6K5A0Fctky3RLBuD+jwSKJaPf1D38PxqfIsQh5ucOvptr
         uKVg4z+uFzEeqy/a76LLDyUEOiBljyMA9C9p4X9d/fisOeppXv5C58fWSf4IziVTdoOW
         U2tNyNdydv77piuU8y8CSjaus8OQrr/i/xpKB72HZY1nYQrEJpeed/Btiwu6/oHDqiJ2
         mF10vfVBRPfvk8fRg1T77RSnwuln+I9Owv5VOn5Tfd+T9tQXNugWl54jw244RUfoykJC
         RIQ2/K6JEIJSXJMTmKJ9FoaTvG9GbaE+EsK5ECOqeZWV8vXqTF7wkfPBiJk0AdZ2mpI1
         /dMw==
X-Gm-Message-State: AOJu0YwobftyjGFo1K8IS83xN1przGUJ/MhAdR6G9zBvDaKL84orTpJ8
	ItkkDNcfTI47UdK71SetrtObw6iwZsygXTsFlbs+1ltIP/tPLNnkKDYksWpz6hM0mlk=
X-Gm-Gg: AY/fxX5Zk19FNmAf/xNsO21yswJZX62D4UPn21cU+T/JaX6HFfEaAmK6+7vJ8ZrF806
	tZuWMB+ZbKWlMDSP/kI4G/6s5QsNV5BhOj2bYJVYtZ6qNfeY2HPsNh30yhGpmNN1gIcCafdScNi
	hq2cm61cUr0wBhX6uJLWH85YZe0898yfcKAv+OvtLNcGbMSlC+EyLGnDKDO3PuJu2odIV9zrhA2
	uuj82+ocpI5A9loGkd/nB6oUkDUR9U0tNWV6KRbonVPHMRbGRiTDHn7Hyh7eMGgqoNEuzyOvz+L
	HVhulo5CH2wXrAwrZiemSqKJf37bZRYYorVOgJ6lqTFiZpWak3mtGIkCiEfuxsaAM6aUAUcDOh7
	hW7uPBjW9Ihizclgw0RMUes67rzjFrIywrkwdQ5P2Za7P2YWfxTTvIl+rxEAGcJy4thwKnKasI+
	T6ByzVstJjM0QJ+qZuRV0ssaohVSdIIyYSWDe5GglguDtnVNUiw/icCbAFhvQhaY5i
X-Google-Smtp-Source: AGHT+IGkhtu4WirGIRcvxGJzynOmGDolnww0jswOOC+3ozxo4XBEyuPeVD82QCUQFxvQXi0eNBg9xg==
X-Received: by 2002:a17:907:6095:b0:b73:99f7:8134 with SMTP id a640c23a62f3a-b8426dd7806mr110738966b.45.1767653562747;
        Mon, 05 Jan 2026 14:52:42 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a233806sm48908866b.10.2026.01.05.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:52:42 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 2/2] Record commit failures as group errors in Updater class so that commit errors are not treated as SUCCESS but as a FAILURE
Date: Mon,  5 Jan 2026 23:47:47 +0100
Message-ID: <20260105224745.581549-4-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105224745.581549-2-t.f.g.geelen@gmail.com>
References: <20260105224745.581549-2-t.f.g.geelen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 22:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2898

What is happening before: commit_changes() throws, run() catches it and removes the group from succeeded_pkggroups_ctx, but it never sets g['error']. The Statistics.update() logic classifies groups purely by g['error'] is None → “Succeeded”. So you end up with “Succeeded: 1” even though commit failed.

Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
---
 upgrade-helper.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 002c3dc..c1c26c0 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -526,6 +526,8 @@ class Updater(object):
             except Exception as e:
                 import traceback
                 E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                # Ensure commit failures are recorded as group errors
+                g['error'] = e
                 if g in succeeded_pkggroups_ctx:
                     succeeded_pkggroups_ctx.remove(g)
                     failed_pkggroups_ctx.append(g)
-- 
2.43.0



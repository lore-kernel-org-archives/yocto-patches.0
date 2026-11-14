Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4398.1794623210130432502
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 18:26:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=VtZyDzyF;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so1268824a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623209; x=1795228009; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2NlTLTGa4I6/VNdZ6lRUoV4eve3rX5drX/bFg/U1lw=;
        b=VtZyDzyFkmQFP7pP/jYHpXPJoAYO9Hb/1b1GaJFVNpplm/QqLeAyMc6ICQu1TA7VW0
         5cu5Mfr0y/r2r1XMy88bJcTk2isac2besau67ngxLI4VcT06c5GRu4gry+wMASorJktt
         aAsfhniEATkVn7uc6tBbM8JCiN9KlbeRoaNxE5HbsSUty6LyYssKREb9IHmGUhz599oO
         gbAs/p0WWsHxqAgDolq/GYDnlfUtQkhdapgCuTmJc70AWUQI9t+IrasZXqQ71URYoEsE
         qfyO6nbQVtcIF1X1GvAS3EN6/b7eSR/6FPaw/fdm/+hCPBm5qV983amoOdvan6nK4M/A
         gphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623209; x=1795228009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2NlTLTGa4I6/VNdZ6lRUoV4eve3rX5drX/bFg/U1lw=;
        b=k5spgBzWram+9N964g6UWmd5cii9xsuVJ+EZgckXwPRhGk/O0KaxVK2FeonsEz10al
         csObiYIUYRuQjIgP3n5nE3behJJUduo8JdpSmwf3wujJt2c7qHDX8ZkYnzj2H41ZgAFw
         03ZXa2qhwhzmhOk04GKcLXlfghakcxZcltGN5hgeXBsEeYoCMPV43u5jJG5GLwSts19P
         3hoMJbVrpLKgi/rPTFxknr8sonQEWPNliMhFRoH2HOZAr04srKbSVzrfRQlGTbfJl3tx
         cuauiZV87LTZNsZ3+ZXL0lmEWAC9hY4mgZeU4i460+FrpuepRe+KZ83sqAfMk6Vs33zX
         Wcmw==
X-Gm-Message-State: APuU4Z9i0sq3qvtcJauchFlJG8x9igAiLDcJCAk9nDNCC+R2bvSioqk5
	09DF81Sp8zCMhHPWboIfd6A+FiisNYk6GFkoYY5j6LTG/Q8asVYVwxJ+7vF4VnaO
X-Gm-Gg: AYBFou1bwY/RwDK13LdGe73bWgWIaIm5AJPZbfGhpUGOZdRK+83IBTlEEpio3MuorJC
	+wgo2AUFul7WT3QZMy9H9notJM7bpR067oucRbtrp9rb5N1uPN9dSZjsf0WVbiookbs7acHUf19
	HUFfwUc1uWLxi6tZEmsD+lwIQiI9r1+3Upc+uKquESqdsPvunxFDrRcX0lV2QyQ9m1GAwJ7aBXo
	1RND5Ho9dARcPz6eUZBjjWly2VqTLbHhcHDzSxL81t7pFpWv6qPOdtzYsgS8LZuvAYKoHJLUDd5
	JSFbrhvVoXJnGjCijW6zRMACO258aCemixudztwuKmX4RL2tTumIiGzbe3sm/oTWlcDsez6l4Fx
	KsAtP7QQFXPyETbhmczD9BhtxsO6SOgbHMuHaZhWqm1Jp5+9wqDNSRyjDGlMATrwpLxZjP8dRHv
	Wm0qCMpm+s74s2CSzbU99nRC0Nb+fFNGZGG2ENV2miECcjoybnEtfmpHZs7YWxDr5qrnsrrGu5g
	fWBanUQZTw6/AzAhaSSQix3JkC8ZhHcXjDJ2coBQUL+mV6WcSE9d6RQaB1TRQWvsvVbeH4Sjub5
	em6gNDurLN80d0btBQvMB9h3cv802W9O+mu2zl87NOzrVSadw6Hbi607lpct/w==
X-Received: by 2002:a17:90b:4d0d:b0:3ad:d4aa:8559 with SMTP id 98e67ed59e1d1-3b1b09f37d9mr3777275a91.17.1794623209438;
        Fri, 13 Nov 2026 18:26:49 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec622b6sm7433636a91.11.2026.11.13.18.26.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 18:26:48 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] templates: warn on the layer page when the first parse failed
Date: Fri, 13 Nov 2026 18:26:37 -0800
Message-ID: <20261114022637.60789-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114022637.60789-1-tim.orling@konsulko.com>
References: <20261114022637.60789-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 02:26:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5359
Content-Type: text/plain; charset="utf-8"

The page of a layer branch that has not been indexed always said that
indexing should happen within a few hours, even when the update had
already failed, e.g. because of a bad conf/layer.conf. Show a warning
with a link to the failed update's log instead.

[YOCTO #13489]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 templates/layerindex/detail.html |  8 ++++++
 tests/test_first_parse_status.py | 49 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/test_first_parse_status.py

diff --git a/templates/layerindex/detail.html b/templates/layerindex/detail.html
index 6c20f47..cc86ff3 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -193,10 +193,18 @@
         </div> <!-- end of container-fluid -->
 
         {% if not layerbranch.vcs_last_commit %}
+        {% with lastupdate=updates.first %}
+        {% if lastupdate.errors %}
+        <div class="alert alert-danger">
+            <b>Warning:</b> The content of this layer on branch {{ url_branch }} could not be indexed: the last update, on {{ lastupdate.started }}, failed. See <a href="{% url 'layerupdate' lastupdate.id %}">its log</a> for the errors.
+        </div>
+        {% else %}
         <div class="alert alert-info">
             <b>Note:</b> The content of this layer on branch {{ url_branch }} has not yet been indexed. Indexing should take place within a few hours.
         </div>
         {% endif %}
+        {% endwith %}
+        {% endif %}
 
         <ul class="nav nav-tabs" id="layertabbar">
             {% if layerbranch.recipe_set.count > 0 %}
diff --git a/tests/test_first_parse_status.py b/tests/test_first_parse_status.py
new file mode 100644
index 0000000..186f64d
--- /dev/null
+++ b/tests/test_first_parse_status.py
@@ -0,0 +1,49 @@
+# layerindex-web - test the layer page of a layer that has not been indexed
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from datetime import datetime
+
+import pytest
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerBranch, LayerItem, LayerUpdate, Update
+
+
+@pytest.fixture
+def new_layer(db):
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layer = LayerItem.objects.create(name='meta-new', status='P', layer_type='A', summary='new',
+                                     description='new', vcs_url='git://example.com/meta-new.git')
+    LayerBranch.objects.create(layer=layer, branch=master)
+    return layer
+
+
+def add_update(layer, log):
+    update = Update.objects.create(started=datetime.now(), finished=datetime.now())
+    layerupdate = LayerUpdate(update=update, layer=layer, branch=Branch.objects.get(name='master'),
+                              started=datetime.now(), finished=datetime.now(), log=log)
+    layerupdate.save()
+    return layerupdate
+
+
+@pytest.mark.django_db
+def test_failed_first_parse_shows_warning(client, new_layer):
+    # [YOCTO #13489]
+    layerupdate = add_update(new_layer, 'ERROR: conf/layer.conf not found for layer meta-new')
+    page = client.get(reverse('layer_item', args=('master', 'meta-new'))).content.decode()
+    assert 'could not be indexed' in page
+    assert reverse('layerupdate', args=(layerupdate.id,)) in page
+    assert 'has not yet been indexed' not in page
+
+
+@pytest.mark.django_db
+def test_not_yet_indexed(client, new_layer):
+    for log in (None, 'WARNING: something'):
+        if log:
+            add_update(new_layer, log)
+        page = client.get(reverse('layer_item', args=('master', 'meta-new'))).content.decode()
+        assert 'has not yet been indexed' in page
+        assert 'could not be indexed' not in page
-- 
2.56.0


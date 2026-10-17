Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E54FCCF2C4
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 16:57:32 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.346.1792256242519619274
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 09:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oQiim6Av;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e95bd1c14cso6763265ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792256242; x=1792861042; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpLo3/AAnt/GG89GZORS4fQcT+goZrlo5Fzhwz8Re3M=;
        b=oQiim6Av6PjIFJvVYVhWkmc/jk7iiDTJIpn4qxdB2pGVw4+3AsNq5JxZUm8URDGCdg
         BpTuE2IXycJY8qIZ50Lth3huedsCZws7VhrTh8Pa/9SYwonHFl5XdBvnbkg6LAHdvW7Q
         0DFYEeoTfqNNFKjJuH6gYRqBH9jos7OMN3/6xvM1YfSkO4KYOIxmriIsq8VbaDb75zJQ
         9y8idmDNwLa34RC1Vny/cbfJyDEgFJCjvYPhN3xHVNw0PZ9jAT8qT5ixx3KHAOvvPjvJ
         JZzUnBVOBTrSvo6kB74RItqdRmLdS5GE0gTa1C5N48sC3jaLYKEi3Tpdos3U5Tx5V6DM
         Ay6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792256242; x=1792861042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpLo3/AAnt/GG89GZORS4fQcT+goZrlo5Fzhwz8Re3M=;
        b=pHiDnTnOQQWLN7qwExYUu/ZyhllgTqqHux8KREc5dya5cbdHYKAfw5X/gFSe0S+uqN
         Fw6ZdeD1BdGTikWZ18pRxvjiIirmzEI3XkcfbhgNZ3NtjlGFf7vF8/1OKSC0n+ROuFGT
         ZPpMw4aqvbs4zoImlKGPKvru9xUAj6IuVHnZelKcVXSOmZhgH3wZj62XDJsJBwjmJjX4
         0xYnMCejSHQ1dVyWcKanb6I/ItSnX1+hcjU1UAWMUDe/VwaIuYUm2ImaO6uJtXkLtL9Y
         +m6x+jci5lbNtPbPOjw2Sq+24BVkfkJUOTflB4PEKvpEpp0iSdqa3+vXU3VJueRsYcOg
         Zi0Q==
X-Gm-Message-State: AFq9FYKZadufyNTPGZxFaJJOeE1BYcmICP27MhhHkMuPwZCTABrcaBY9
	VxYHppOQNYUItWYqoFG0a8LkNwLAO2RxwaX5gKKrdkOxtTAzBCB2J53nJU1FcQ==
X-Gm-Gg: AYBFou2ZcXqMPQjeafFbWpn9nWesU4lo7e5x58zHntUYT3d+av/C1OZ/zyO+/U0rYoX
	yFiS9KsoHBfbqkzY1M06dcI7RWwhHu/hwZ7pDaHUIzxeKMLPbjpRlY5w7P17pXJvzKks9IoO3aH
	0jcrNOsJVm49XnnhSJ1hVLpE0KTi0pRoYxhK1rS47vsqSG5ln+e/Vw/sjIbH30AcSTCJy6Ub+Rn
	YXa+xgtJahmZzBW+G669xWZCmZDOtKb7Ot6/yW6f3YvrpBbYkFGHuxG8n8XaA+X0mdEJOvPk2ve
	ukC4AbZLtvtUJY8N12lvsCYNrZLA9AvdfBF80px+7oWhjWUmUiUjlXLvPYOoH3ECX/NOVu4xXHC
	NyA7mx8gqHRJsrBJ9DNrEvTegzrE1SdCXRVSu8Eje015+CMIDZZtHs+QW6J4Hrcj4erzWQ8gJFN
	B0KvBNNFG3t5KZD8PnGR9/mYzhbcJTLWez0BDLyT8Ydhz7j1J5t84l3X9rw92TfY0I6wW774F3I
	VdRg4BVa2i73R/+420aeNhBw9Q0+1w=
X-Received: by 2002:a17:903:22c3:b0:2e9:9846:2da7 with SMTP id d9443c01a7336-2e9a68437f0mr31887775ad.5.1792256241775;
        Sat, 17 Oct 2026 09:57:21 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7efcsm22402035ad.5.2026.10.17.09.57.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 09:57:20 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] layerindex/views: BranchCompareView: parse layers as a list of ids
Date: Sat, 17 Oct 2026 09:57:03 -0700
Message-ID: <20261017165703.70617-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017165703.70617-1-tim.orling@konsulko.com>
References: <20261017165703.70617-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 16:57:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5038

The 'layers' parameter is a comma-separated list of layer ids, but the
view used the raw string as the list and iterated over it one character
at a time. As a result:

 * layers=59 compared layers 5 and 9 instead of layer 59
 * layers=59,1 tried to look up a layer with id ',' and raised a
   ValueError (Internal Server Error)
 * the "Filter layers" badge showed the length of the string rather
   than the number of layers (e.g. 3 for "2,1")
 * the selected layers were not pre-checked in the layer dialog, since
   integer ids were being compared against a string

Split the parameter into integer ids (also accepting it repeated, as in
layers=59&layers=1), ignore anything that is not a published layer id,
and use the cleaned list for the hidden form field, the badge and the
text/rST/CSV output. Add tests covering these cases.

Fixes [YOCTO #15332]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py               |  19 +++++-
 tests/test_branch_compare_view.py | 109 ++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 3 deletions(-)
 create mode 100644 tests/test_branch_compare_view.py

diff --git a/layerindex/views.py b/layerindex/views.py
index 73a4f6a..dea0a98 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1902,6 +1902,19 @@ class BranchCompareView(FormView):
                 changed.append(recipe)
         return added, changed, removed
 
+    def get_layer_ids(self):
+        # 'layers' is a comma-separated list of layer ids (also accept it
+        # repeated); ignore anything that isn't a selectable layer
+        valid_ids = set(LayerItem.objects.filter(status__in=['P', 'X']).values_list('id', flat=True))
+        values = self.request.GET.getlist('layers') or [str(LayerItem.objects.get(name=settings.CORE_LAYER_NAME).id)]
+        layer_ids = []
+        for value in values:
+            for layer_id in value.split(','):
+                layer_id = layer_id.strip()
+                if layer_id.isdigit() and int(layer_id) in valid_ids and int(layer_id) not in layer_ids:
+                    layer_ids.append(int(layer_id))
+        return layer_ids
+
     def form_valid(self, form):
         return HttpResponseRedirect(reverse_lazy('branch_comparison', args=(form.cleaned_data['from_branch'].name, form.cleaned_data['to_branch'].name)))
 
@@ -1913,7 +1926,7 @@ class BranchCompareView(FormView):
         to_branch_id = self.request.GET.get('to_branch', None)
         if to_branch_id is not None:
             initial['to_branch'] = get_object_or_404(Branch, id=to_branch_id)
-        initial['layers'] = self.request.GET.get('layers', str(LayerItem.objects.get(name=settings.CORE_LAYER_NAME).id))
+        initial['layers'] = ','.join(str(i) for i in self.get_layer_ids())
         return initial
 
     def get_context_data(self, **kwargs):
@@ -1921,7 +1934,7 @@ class BranchCompareView(FormView):
         from_branch_id = self.request.GET.get('from_branch', None)
         to_branch_id = self.request.GET.get('to_branch', None)
 
-        layer_ids = self.request.GET.get('layers', str(LayerItem.objects.get(name=settings.CORE_LAYER_NAME).id))
+        layer_ids = self.get_layer_ids()
         from_branch = None
         if from_branch_id is not None:
             from_branch = get_object_or_404(Branch, id=from_branch_id)
@@ -1936,7 +1949,7 @@ class BranchCompareView(FormView):
         context['layers'] = LayerItem.objects.filter(status__in=['P', 'X']).order_by('name')
         context['showlayers'] = layer_ids
         layerlist = dict(context['layers'].values_list('id', 'name'))
-        context['showlayers_text'] = ', '.join([layerlist[int(i)] for i in layer_ids])
+        context['showlayers_text'] = ', '.join([layerlist[i] for i in layer_ids])
 
         return context
 
diff --git a/tests/test_branch_compare_view.py b/tests/test_branch_compare_view.py
new file mode 100644
index 0000000..6211c5f
--- /dev/null
+++ b/tests/test_branch_compare_view.py
@@ -0,0 +1,109 @@
+# layerindex-web - tests for BranchCompareView
+#
+# Copyright (C) 2026 Tim Orling <tim.orling@konsulko.com>
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+# Tests for bug #15332 - Branch Comparison throws Internal Server Error
+# https://bugzilla.yoctoproject.org/show_bug.cgi?id=15332
+#
+# The 'layers' parameter is a comma-separated list of layer ids, but the view
+# iterated over the raw string character by character. So layers=59 selected
+# layers 5 and 9, and layers=59,1 tried to look up a layer with id ','.
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerItem, LayerBranch, Recipe
+
+
+@pytest.mark.django_db
+class TestBranchCompareView(TestCase):
+    """Tests for BranchCompareView layer selection (bug #15332)."""
+
+    def setUp(self):
+        self.from_branch = Branch.objects.create(
+            name='old', bitbake_branch='old', short_description='Old',
+            sort_priority=2)
+        self.to_branch = Branch.objects.create(
+            name='new', bitbake_branch='new', short_description='New',
+            sort_priority=1)
+
+        # Explicit ids so that '59' would be misread as layers 5 and 9
+        self.layers = {}
+        for layer_id, name in ((1, 'openembedded-core'), (5, 'meta-five'),
+                               (9, 'meta-nine'), (59, 'meta-fiftynine')):
+            layer = LayerItem.objects.create(
+                id=layer_id, name=name, status='P', layer_type='S',
+                summary=name, description=name,
+                vcs_url='git://example.com/%s.git' % name)
+            self.layers[layer_id] = layer
+            for branch, pv in ((self.from_branch, '1.0'), (self.to_branch, '2.0')):
+                lb = LayerBranch.objects.create(layer=layer, branch=branch)
+                Recipe.objects.create(
+                    layerbranch=lb, filename='%s_%s.bb' % (name, pv),
+                    pn='%s-recipe' % name, pv=pv, filepath='recipes-test')
+
+    def _get(self, query='', url_name='branch_comparison'):
+        url = '%s?from_branch=%d&to_branch=%d%s' % (
+            reverse(url_name), self.from_branch.id, self.to_branch.id, query)
+        response = self.client.get(url)
+        self.assertEqual(response.status_code, 200)
+        return response
+
+    def _changed_pns(self, response):
+        return sorted(r.pn for r in response.context['changed'])
+
+    def test_default_is_core_layer(self):
+        response = self._get()
+        self.assertEqual(self._changed_pns(response), ['openembedded-core-recipe'])
+
+    def test_multi_digit_layer_id(self):
+        response = self._get('&layers=59')
+        self.assertEqual(self._changed_pns(response), ['meta-fiftynine-recipe'])
+        self.assertEqual(response.context['showlayers_text'], 'meta-fiftynine')
+
+    def test_multiple_layers(self):
+        response = self._get('&layers=59%2C1')
+        self.assertEqual(self._changed_pns(response),
+                         ['meta-fiftynine-recipe', 'openembedded-core-recipe'])
+
+    def test_repeated_layers_param(self):
+        response = self._get('&layers=59&layers=1')
+        self.assertEqual(self._changed_pns(response),
+                         ['meta-fiftynine-recipe', 'openembedded-core-recipe'])
+
+    def test_legacy_url_with_l_params(self):
+        # URL as previously generated by the form, with the checkbox values
+        # also submitted as 'l'
+        response = self._get('&layers=59%2C1&l=59&l=1')
+        self.assertEqual(self._changed_pns(response),
+                         ['meta-fiftynine-recipe', 'openembedded-core-recipe'])
+
+    def test_invalid_layer_ids_ignored(self):
+        response = self._get('&layers=59%2C%2Cbogus%2C9999')
+        self.assertEqual(self._changed_pns(response), ['meta-fiftynine-recipe'])
+
+    def test_badge_and_checkboxes_match_selection(self):
+        response = self._get('&layers=59%2C1')
+        self.assertContains(response, 'id="id_layers_count">2</span>', html=False)
+        content = response.content.decode()
+        for layer_id in (1, 59):
+            self.assertRegex(content, r'id="id_layercheckbox_%d"\s+checked' % layer_id)
+        for layer_id in (5, 9):
+            self.assertNotRegex(content, r'id="id_layercheckbox_%d"\s+checked' % layer_id)
+        # Checkboxes must not be submitted alongside the hidden 'layers' field
+        self.assertNotContains(response, 'name="l"')
+
+    def test_plain_text_output(self):
+        response = self._get('&layers=59%2C1', url_name='branch_comparison_plain')
+        self.assertContains(response, '(layers: meta-fiftynine, openembedded-core)')
+
+    def test_from_branch_only(self):
+        url = '%s?from_branch=%d' % (reverse('branch_comparison'), self.from_branch.id)
+        response = self.client.get(url)
+        self.assertEqual(response.status_code, 200)
+        self.assertIsNone(response.context['to_branch'])
-- 
2.56.0



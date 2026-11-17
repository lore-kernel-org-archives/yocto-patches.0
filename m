Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1117.1794943827602724542
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Nov 2026 11:30:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=I3HUKJj6;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso169926a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794943826; x=1795548626; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4INEBgMnUSCRh2EXkbXORBikj5isswC3EtAbnl0Nr4=;
        b=I3HUKJj6sFH93CZ9GpIULptrXHocum+dMSIDOmdfbw5ANs4nlC5hEgGyH0qtEzmIB1
         dCrPVJzj69LGy8fsKH/HhVT95Rt/fFR/7c7Dc5N1PC7s6D4Gxw2maOhBP5S4Y57n9FxP
         SqlUGMRrjcSDpWVRHG2BS7RQZOooZLb3U9y9IwyIBZ2vOVdfZDqFdz7nC0kf0FCiMogZ
         CGRJnInRxpVJNRihxbkxP6PG4/Twxi1aNLDedrKk90tTvKwfZQhZXqLzDJk4RPW6g2MP
         SdyH8LAKPreqhXhzoC84YBQHiDt2EX4qzWeo+uJ3JkraA5BG6HbNKiIQwmUguy5fKO3y
         36JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943826; x=1795548626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4INEBgMnUSCRh2EXkbXORBikj5isswC3EtAbnl0Nr4=;
        b=lLg02PJWITmKx7jtdpZyjK68SPggrAUsvm6tTtTpeUEDX/xQMW53vyENhxgTCXZf1M
         iBf7qPSkAbcawluXbRaJT7wx3+Mt/XZCdb0ynkIE7oSbwKy1FhxPZMmDXxzO71XSn8iT
         YYshgOe8RGd6cfbnnwkXuAi6LxTbTkfyYD4llEhiDq7n1ubhSwhk9B7BxQeyPyBzSFqh
         BJkU8NAfp7zuAz/rXgginqQIUMFaXy6Az8st0F6PoFMendyZAYxJ7p5UtxPKzJ/z0QR4
         LLPSs0G7qGOMbwtsQh8iGcHmYDk34k7bveDpWEAEcXWIQ0gzVICgTqkbXrEk55XAeRxN
         Taag==
X-Gm-Message-State: APuU4Z9N8AVOsc2BJjfgsOJCTYW5sc0MP8/hEH/g4H+TXZfyGMOuoZj6
	+JZ2AjmUlRh1LEY/UyITzyf/IuN4XRIsDUwyYxe+InwNz4vcoQOp6zWbzEbvbw==
X-Gm-Gg: AZFdTZcy7aBW61zsIrXg7XLfkC/Jcc2jj+zMXFOrAMUookqTzwtYo9vXNDMik8fF0Rd
	n2mze61Vaaq+6/+NPqFgPKUgvbL0vDCqjbP5ybhg1PgbjL7RDyE9gHWhSsSayQNG/3joLNgFfoB
	xZYZdfIEQyT1iGVBIgj4ATzCCr4FjWIiMt6Evd/l0h4LCjwBQirAKS4IHnN+BGgeFE1Es/OWNSd
	rGedJx1V74djL6BjehSjanU7xDpxQlTmG1KbcL61zE4AKUExOtgGQfbYaaLWIspYJbzJCyc5Zkh
	7fqawWb7kHvGgDTuLnx/syltka9mje85haaGgSAAesoq5ilPMTSeLk8KGycP1GGCRPU1xspT1Yn
	6WWXGQA8Gb8g+Jb/W+QYNgWZ03IJIt/szH45GpDua7C4ZYf9gc+eHjcVfACFVtRfEsEjLaFSvGN
	npq+9AuIqpFaTKQylTiQizgC00XHKmttgF3GVf8alUnuPbj9AaVtK/QyN1ZgmBStaJfVHW6vlq/
	GP75l8cCS7P/mX3kLd2SII1DT6dCwwQcX3bQHQRjTljADUJWbytIDmRwXU6nbHMrp8Htr8DHu0u
	VP+JosbFHL4FGCPpu0074DzKNmYI84pCrp0mzKTjOoOp06PI+cPd8Hf0
X-Received: by 2002:a17:90b:4b88:b0:3b1:ba59:56a1 with SMTP id 98e67ed59e1d1-3b3d07ca529mr380594a91.39.1794943826363;
        Tue, 17 Nov 2026 11:30:26 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac70ea45sm5252462a91.17.2026.11.17.11.30.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 11:30:22 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex/restviews.py: stream unpaginated JSON lists
Date: Tue, 17 Nov 2026 11:29:38 -0800
Message-ID: <20261117192938.22269-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 19:30:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5466
Content-Type: text/plain; charset="utf-8"

Most API lists aren't paginated, and clients such as bitbake's
layerindexlib fetch whole tables: /layerindex/api/recipes/ is about
300 MB of JSON. Building that in one piece took a worker to 1.6 GB. Send
JSON lists a chunk of 2000 objects at a time instead, with the same
output; paginated lists and the browsable API are unchanged.

Tests that read an unpaginated list now read the streamed content, and
the API contract tests check the shape of the streamed responses.

[YOCTO #16525]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/restviews.py             | 34 +++++++++++++++
 tests/test_api_contract.py          |  3 ++
 tests/test_published_layers_feed.py |  4 +-
 tests/test_restapi.py               |  9 ++--
 tests/test_restapi_stream.py        | 65 +++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100644 tests/test_restapi_stream.py

diff --git a/layerindex/restviews.py b/layerindex/restviews.py
index 1b6b926..c55c444 100644
--- a/layerindex/restviews.py
+++ b/layerindex/restviews.py
@@ -7,7 +7,9 @@
 # SPDX-License-Identifier: MIT
 
 from layerindex.models import Branch, LayerItem, LayerMaintainer, YPCompatibleVersion, LayerNote, LayerBranch, LayerDependency, Recipe, Machine, Distro, BBClass, Source, Patch, PackageConfig, StaticBuildDep, DynamicBuildDep, RecipeFileDependency, BBAppend, IncFile
+from django.http import StreamingHttpResponse
 from rest_framework import viewsets, serializers, pagination
+from rest_framework.renderers import JSONRenderer
 from layerindex.querysethelper import params_to_queryset, get_search_tuple
 
 class LayerIndexPagination(pagination.PageNumberPagination):
@@ -41,6 +43,38 @@ class ParametricSearchableModelViewSet(viewsets.ReadOnlyModelViewSet):
         (filter_string, search_term, ordering_string) = get_search_tuple(self.request, model)
         return params_to_queryset(model, qs, filter_string, search_term, ordering_string)
 
+    # Objects serialised at a time when streaming a list
+    stream_chunk_size = 2000
+
+    def list(self, request, *args, **kwargs):
+        # An unpaginated list can be a whole table: all the recipes are 300 MB
+        # of JSON, which took a worker to 1.6 GB when built in one piece. Send
+        # JSON a chunk at a time instead, in the same format. Other renderers
+        # (e.g. the browsable API) build the whole response as before.
+        # (AI-generated, Claude Opus 5.5)
+        renderer = request.accepted_renderer
+        if self.paginator is not None or not isinstance(renderer, JSONRenderer):
+            return super().list(request, *args, **kwargs)
+        # Evaluated here, so that an invalid filter is still an error response
+        queryset = self.filter_queryset(self.get_queryset())
+        return StreamingHttpResponse(self.stream_json(queryset, renderer),
+                                     content_type=renderer.media_type)
+
+    def stream_json(self, queryset, renderer):
+        # The objects of each chunk, rendered as a list without its brackets
+        yield b'['
+        separator = b''
+        chunk = []
+        for obj in queryset.iterator(chunk_size=self.stream_chunk_size):
+            chunk.append(obj)
+            if len(chunk) == self.stream_chunk_size:
+                yield separator + renderer.render(self.get_serializer(chunk, many=True).data)[1:-1]
+                separator = b','
+                chunk = []
+        if chunk:
+            yield separator + renderer.render(self.get_serializer(chunk, many=True).data)[1:-1]
+        yield b']'
+
 class BranchSerializer(DynamicFieldsModelSerializer):
     class Meta:
         model = Branch
diff --git a/tests/test_api_contract.py b/tests/test_api_contract.py
index 5de9427..feec1a6 100644
--- a/tests/test_api_contract.py
+++ b/tests/test_api_contract.py
@@ -90,6 +90,9 @@ def api(client, seeded_index):
         response = client.get('/layerindex/api/' + path, params)
         assert response.status_code == 200, path
         assert response['Content-Type'] == 'application/json', path
+        # An unpaginated list is streamed (AI-generated, Claude Opus 5.5)
+        if response.streaming:
+            return json.loads(b''.join(response.streaming_content))
         return response.json()
     return get
 
diff --git a/tests/test_published_layers_feed.py b/tests/test_published_layers_feed.py
index 7554677..26e6664 100644
--- a/tests/test_published_layers_feed.py
+++ b/tests/test_published_layers_feed.py
@@ -1,4 +1,5 @@
 import datetime
+import json
 import xml.etree.ElementTree as ET
 from email.utils import parsedate_to_datetime
 from urllib.parse import urlsplit
@@ -290,7 +291,8 @@ def test_published_date_is_not_in_the_rest_api(new_layer, publish, client):
 
     response = client.get('/layerindex/api/layerItems/', {'format': 'json'})
 
-    data = response.json()
+    # The list is streamed (AI-generated, Claude Opus 5.5)
+    data = json.loads(b''.join(response.streaming_content))
     items = data['results'] if isinstance(data, dict) else data
     (item,) = [i for i in items if i['name'] == 'meta-foo']
     assert 'published' not in item
diff --git a/tests/test_restapi.py b/tests/test_restapi.py
index fde1aec..20254c2 100644
--- a/tests/test_restapi.py
+++ b/tests/test_restapi.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: MIT
 
 import datetime
+import json
 
 import pytest
 from django.test import TestCase
@@ -24,7 +25,8 @@ class TestRestApiDatetimes(TestCase):
 
         response = self.client.get('/layerindex/api/layerItems/', {'format': 'json'})
         self.assertEqual(response.status_code, 200)
-        data = response.json()
+        # Unpaginated lists are streamed
+        data = json.loads(b''.join(response.streaming_content))
         items = data['results'] if isinstance(data, dict) else data
         item = next(i for i in items if i['name'] == 'meta-test')
         self.assertEqual(item['updated'], '2026-10-18T14:37:05+0000')
@@ -59,7 +61,8 @@ class TestRestApiInvalidParameters(TestCase):
         response = self.client.get('/layerindex/api/layerItems/',
                                    {'filter': 'name:meta-test', 'format': 'json'})
         self.assertEqual(response.status_code, 200)
-        self.assertEqual([i['name'] for i in response.json()], ['meta-test'])
+        self.assertEqual([i['name'] for i in json.loads(b''.join(response.streaming_content))],
+                         ['meta-test'])
 
 
 @pytest.mark.django_db
@@ -76,7 +79,7 @@ class TestRestApiOrderby(TestCase):
         response = self.client.get('/layerindex/api/layerItems/',
                                    {'orderby': orderby, 'format': 'json'})
         self.assertEqual(response.status_code, 200)
-        return [i['name'] for i in response.json()]
+        return [i['name'] for i in json.loads(b''.join(response.streaming_content))]
 
     def test_ascending(self):
         self.assertEqual(self.names('name:+'), ['meta-a', 'meta-b', 'meta-c'])
diff --git a/tests/test_restapi_stream.py b/tests/test_restapi_stream.py
new file mode 100644
index 0000000..48cc36f
--- /dev/null
+++ b/tests/test_restapi_stream.py
@@ -0,0 +1,65 @@
+# layerindex-web - tests for streamed REST API lists
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# An unpaginated list is sent a chunk at a time, so a whole table never has to
+# be built in memory, and the JSON is the same as before. tests/test_api_contract.py
+# checks the shape of the streamed responses.
+
+import json
+from unittest import mock
+
+from layerindex.models import Recipe
+from layerindex.restviews import ParametricSearchableModelViewSet, RecipeSerializer
+
+
+def get_recipes(client, **params):
+    return client.get('/layerindex/api/recipes/', params)
+
+
+def content(response):
+    return b''.join(response.streaming_content)
+
+
+def test_streamed_in_chunks(client, seeded_index):
+    # Chunks of 3 for 4 recipes: the last chunk is short
+    with mock.patch.object(ParametricSearchableModelViewSet, 'stream_chunk_size', 3):
+        response = get_recipes(client, format='json')
+        assert response.status_code == 200
+        assert response.streaming
+        assert response['Content-Type'] == 'application/json'
+        data = json.loads(content(response))
+    expected = RecipeSerializer(Recipe.objects.order_by('id'), many=True).data
+    assert data == json.loads(json.dumps(expected))
+
+
+def test_whole_chunks(client, seeded_index):
+    with mock.patch.object(ParametricSearchableModelViewSet, 'stream_chunk_size', 2):
+        data = json.loads(content(get_recipes(client, format='json')))
+    assert len(data) == Recipe.objects.count() == 4
+
+
+def test_empty_list(client, seeded_index):
+    assert content(get_recipes(client, format='json', filter='pn:nosuchrecipe')) == b'[]'
+
+
+def test_filter_still_applies(client, seeded_index):
+    data = json.loads(content(get_recipes(client, format='json', filter='pn:base-example')))
+    assert [r['pn'] for r in data] == ['base-example']
+
+
+def test_paginated_list_not_streamed(client, seeded_index):
+    response = client.get('/layerindex/api/recipesExtended/', {'format': 'json'})
+    assert response.status_code == 200
+    assert not response.streaming
+    assert response.json()['count'] == 4
+
+
+def test_browsable_api_not_streamed(client, seeded_index):
+    response = client.get('/layerindex/api/recipes/', HTTP_ACCEPT='text/html')
+    assert response.status_code == 200
+    assert not response.streaming
-- 
2.56.1


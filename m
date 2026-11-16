Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6135.1794870254281308031
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:04:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=x+vFm2Y+;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so4182197b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794870253; x=1795475053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLyHzlRnzU04rYjseLJm6GTKPWN3tA0X42DVVvUUQlM=;
        b=x+vFm2Y+JYnFutj7Sawki0FamPcJS7wog65PBzpQPF9ysh2ZHaFiUmLILQymFaZH8f
         mOlzvFF8IyStftdXRuhPCUl28z4LoPPad5kx0bXmFBJn7rC51AfR5fTt0bCRPPPHAceh
         kjLAfiEECKeJwmvk4UUxiwWnz9qVtqbgHb/tkXgijBu2i9u7NZOpEJ4jQFO16Td3J0Qb
         SDrDH7wW9FXQ+cxLeZoHsapWYTZkTU+MpIaQBo/kV9WmA9FxwiOUj9ThcpuscFfYxWag
         7DEdwKd1ZoqH8swX+8lzGCl2yS1FwCvKnmbYnVEY99oxuLKcl1uiq9wlb0aWoqsVSfzE
         5kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870253; x=1795475053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLyHzlRnzU04rYjseLJm6GTKPWN3tA0X42DVVvUUQlM=;
        b=avTfqb0hgWtf56rDqDylvlSxbb/RnGG1DIq70wUitZxG0AU19PEBCYbzQFDMs91tJq
         KZ9IAcOYG1Vt9w445u7rtl8JNar1sJqSJ6uWgwWjSlneK/UKYeoxOamxnk4KE8OdfeN5
         /5ntBni0N6oOFkvhWBC1FiAxv8ig+2YkdtIzwzDjwWpLN3Y2HMrkXMygFyyNL8kI1W5B
         emSzJFxEaMNFLJ3BDv2MNp3qCjAhKLe43bb2tEzbG46AF5ei0QgtCdySznRD2R9aCTTr
         NoLIo7BQpky7gXmGqGzA9mKFC+yuTlPisb4gXLyLXbpUFCW1Eb9dk3iLhMi272evWcx6
         TWIA==
X-Gm-Message-State: APuU4Z+EeZEhWyWHuuDoU7oMnRXp0j2WkUwuFnzq7b7+eH7Iet2NYCAw
	q5Ma0tk5vGX8ZGJNQ4LlySGsiMl4KEKrGXnDozcI5EdCi89gQadBbssEeNfGGA==
X-Gm-Gg: AYBFou2BcJ3aj/GAzLr0tx77EpQYf8ZS/C9cls/lPckKPnJD7XRI8pxqUT/Y7Kt6mcQ
	n+/1snHAWEk3txIYFpbAorhnA5mDt6b125UelSliUO42pkmLgCByDStOKS6O9sQe86nl61FBULe
	VHl4rFmMNIxpUne7VTFOITVqbptHwdVu5PFc1ih2yC70ZBStN6yKRKcfOFWmKsWewe1NNau+j6+
	Aw2duh4J6CI4k4bgHpNF1pANczOj+sbqZT3f5WrlrsX8kSU7gvQA/Am9x2yrKKyDCnY8r4tuLgY
	wPHq2qctqmriaHWoJ/oehdPGv2LUywwP9+nhnGpbduuHqGSas5NIQjQ4+VM5Xuwmovw5rnNUHSl
	OgHEZOU0Gq2qkR4lnKBpGhlsgt3DBmWSnHbC+uGZa3ys9nH/aN8XKkdMaN3l0YFFiE9Ps+r6EvM
	qxguoSbkpLUKa0gBeCIS9tpvmfiykgdYnH7Joth53HIUk4vNMOr1Z16fDCSHztBuSKK5HS/s8zd
	fgAzHp4WYM1EEb97HDGm9plW/kWBrLrmDpcq9fJNmY3+boyUER4NPC/0WhvYFcf6LEPu2x4L6+M
	JYNwjOzN0ZJEisQXTwHRJIINISbjsC6BEzmRJvecaCq4rQYfsnZ1YIZQHOxcDQ==
X-Received: by 2002:a05:6a21:a46:b0:3e2:7a05:6bda with SMTP id adf61e73a8af0-3f7a83ba040mr12724825637.43.1794870253316;
        Mon, 16 Nov 2026 15:04:13 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a90f1sm4210535b3a.19.2026.11.16.15.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 15:04:12 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] layerindex/querysethelper.py: reject an invalid API filter or orderby with a 400
Date: Mon, 16 Nov 2026 15:03:49 -0800
Message-ID: <20261116230401.42917-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116230401.42917-1-tim.orling@konsulko.com>
References: <20261116230401.42917-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:04:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5435
Content-Type: text/plain; charset="utf-8"

An unknown field in "filter" or "orderby" raised BaseException, which
neither Django nor the WSGI server catches, so the worker died and the
client got a 502 (uWSGI) or 500. A filter value of the wrong type for
its field, e.g. filter=id:abc, raised ValueError and gave a 500. Raise
the REST framework's ParseError instead, which returns a 400 with the
reason.

[YOCTO #16517]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/querysethelper.py | 16 ++++++++++++----
 tests/test_restapi.py        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/layerindex/querysethelper.py b/layerindex/querysethelper.py
index 0d1f317..2ca466a 100644
--- a/layerindex/querysethelper.py
+++ b/layerindex/querysethelper.py
@@ -8,7 +8,9 @@
 
 import operator
 import functools
+from django.core.exceptions import FieldError, ValidationError
 from django.db.models import Q, CharField
+from rest_framework.exceptions import ParseError
 
 def _verify_parameters(g, mandatory_parameters):
     miss = []
@@ -109,12 +111,14 @@ def _get_search_results(search_term, queryset, model):
 # it uses the request and the model to validate input for the filter and orderby values
 def get_search_tuple(request, model):
     ordering_string, invalid = _validate_input(request.GET.get('orderby', ''), model)
+    # A 400 for the client: BaseException isn't caught by Django or the WSGI
+    # server, so it killed the worker (AI-generated, Claude Opus 5.5)
     if invalid:
-        raise BaseException("Invalid ordering model:" + str(model) + str(invalid))
+        raise ParseError("Invalid orderby: " + str(invalid))
 
     filter_string, invalid = _validate_input(request.GET.get('filter', ''), model)
     if invalid:
-        raise BaseException("Invalid filter " + str(invalid))
+        raise ParseError("Invalid filter: " + str(invalid))
 
     search_term = request.GET.get('search', '')
     return (filter_string, search_term, ordering_string)
@@ -123,8 +127,12 @@ def get_search_tuple(request, model):
 # returns a lazy-evaluated queryset for a filter/search/order combination
 def params_to_queryset(model, queryset, filter_string, search_term, ordering_string):
     if filter_string:
-        filter_query = _get_filtering_query(filter_string)
-        queryset = queryset.filter(filter_query)
+        try:
+            filter_query = _get_filtering_query(filter_string)
+            queryset = queryset.filter(filter_query)
+        except (ValueError, ValidationError, FieldError) as e:
+            # e.g. filter=id:abc (AI-generated, Claude Opus 5.5)
+            raise ParseError("Invalid filter: " + str(e))
     else:
         queryset = queryset.all()
 
diff --git a/tests/test_restapi.py b/tests/test_restapi.py
index af1f708..a1f733e 100644
--- a/tests/test_restapi.py
+++ b/tests/test_restapi.py
@@ -28,3 +28,35 @@ class TestRestApiDatetimes(TestCase):
         items = data['results'] if isinstance(data, dict) else data
         item = next(i for i in items if i['name'] == 'meta-test')
         self.assertEqual(item['updated'], '2026-10-18T14:37:05+0000')
+
+
+@pytest.mark.django_db
+class TestRestApiInvalidParameters(TestCase):
+    """Invalid filter and orderby values give a 400 ([YOCTO #16517])"""
+
+    def assert_bad_request(self, params):
+        response = self.client.get('/layerindex/api/layerItems/', dict(params, format='json'))
+        self.assertEqual(response.status_code, 400, params)
+
+    def test_unknown_filter_field(self):
+        # Raised BaseException, which killed the worker
+        self.assert_bad_request({'filter': 'pn:x'})
+
+    def test_filter_without_value(self):
+        self.assert_bad_request({'filter': 'name'})
+
+    def test_filter_value_of_wrong_type(self):
+        # Raised ValueError: a 500
+        self.assert_bad_request({'filter': 'id:abc'})
+
+    def test_unknown_orderby_field(self):
+        self.assert_bad_request({'orderby': 'pn:-'})
+
+    def test_valid_filter(self):
+        LayerItem.objects.create(name='meta-test', status='P', layer_type='A',
+                                 summary='test', description='test',
+                                 vcs_url='git://example.com/meta-test.git')
+        response = self.client.get('/layerindex/api/layerItems/',
+                                   {'filter': 'name:meta-test', 'format': 'json'})
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual([i['name'] for i in response.json()], ['meta-test'])
-- 
2.56.1


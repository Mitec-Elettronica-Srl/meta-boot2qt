#!/bin/bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

# Checkout latest revision of all or selected meta layers and update the sha1s to the manifest.xml

MANIFEST=$(dirname $(realpath $0))/manifest.xml

REPOS=${@:-$(repo list -n)}
REPOS=${REPOS//meta-boot2qt}

repo sync $REPOS -n
repo forall $REPOS -c "\
 git checkout \$REPO_REMOTE/\$REPO_UPSTREAM ; \
 echo \$REPO_PROJECT has \$(git rev-list --count \$REPO_LREV..HEAD) new commits; \
 if [ \"\$(git describe --abbrev=0 \$REPO_LREV)\" != \"\$(git describe --abbrev=0 HEAD)\" ]; then \
  echo \"  new tag available: \$(git describe --abbrev=0 HEAD)\"; \
 fi ; \
 sed -e s/\$REPO_LREV/\$(git rev-parse HEAD)/ \
     -e \"/\$REPO_PROJECT/,/revision/s|\$REPO_RREV|\$(git rev-parse HEAD)|\" \
     -i ${MANIFEST}"

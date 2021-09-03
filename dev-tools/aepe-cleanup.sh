#!/bin/bash

mv $1*ServiceImpl.cls $1services/
mv $1*ServiceImpl.cls-meta.xml $1services/
mv $1*ServiceTest.cls $1services/
mv $1*ServiceTest.cls-meta.xml $1services/
mv $1I*Service.cls $1services/interfaces/
mv $1I*Service.cls-meta.xml $1services/interfaces/
mv $1*Service.cls $1services/interfaces/
mv $1*Service.cls-meta.xml $1services/interfaces/
mv $1*Service.cls-meta.xml $1services/interfaces/

mv $1I*Selector.cls $1selectors/interfaces/
mv $1I*Selector.cls-meta.xml $1selectors/interfaces/
mv $1*Selector.cls $1selectors/
mv $1*Selector.cls-meta.xml $1selectors/

mv $1*sTest.cls $1domains/
mv $1*sTest.cls-meta.xml $1domains/
mv $1I*s.cls $1domains/interfaces/
mv $1I*s.cls-meta.xml $1domains/interfaces/
mv $1*s.cls $1domains/
mv $1*s.cls-meta.xml $1domains/


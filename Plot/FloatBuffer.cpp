#include "FloatBuffer.h"

FloatBuffer::FloatBuffer(QObject *parent):
    QObject(parent),
    m_secondsPerSample(0.00001),
    m_start(0),
    m_length(0),
    m_first_samples_ignored(0),
    m_start_test(0)
    {}

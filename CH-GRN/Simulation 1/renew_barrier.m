%����ϰ������ƶ������ϰ���λ�ý��и���
function pattern_barrier = renew_barrier(barrier)
    [~,num_barrier] = size(barrier);
    pattern_barrier = zeros(100);
    for id = 1:num_barrier
        barrier(id).pointx = barrier(id).nextx;
        barrier(id).pointy = barrier(id).nexty;
        pattern_barrier = pattern_barrier + barrier(id).pattern_barrier;
    end
    pattern_barrier = pattern_barrier';
end
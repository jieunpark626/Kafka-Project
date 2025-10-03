package kafka.server

import org.apache.kafka.common.TopicPartition
import org.apache.kafka.common.record.SimpleRecord
import java.util.concurrent.ConcurrentHashMap
import java.util.{PriorityQueue => JPriorityQueue}

object PriorityQueue {
  private val queues = new ConcurrentHashMap[TopicPartition, JPriorityQueue[(Int, SimpleRecord)]]()

  def create(tp: TopicPartition): JPriorityQueue[(Int, SimpleRecord)] = {
    if (queues.containsKey(tp))
      return queues.get(tp)
    else {
      val newPriorityQueue = new JPriorityQueue[(Int, SimpleRecord)](
        (a: (Int, SimpleRecord), b: (Int, SimpleRecord)) => Integer.compare(b._1, a._1)
      )
      queues.put(tp, newPriorityQueue)
      return newPriorityQueue
    }
  }

  def poll(tp: TopicPartition, max: Int): List[SimpleRecord] = {
    val pq = queues.get(tp)
    val result = new scala.collection.mutable.ListBuffer[SimpleRecord]()
    while (pq != null && !pq.isEmpty && result.size < max) {
      result += pq.poll()._2
    }
    result.toList
  }
}
